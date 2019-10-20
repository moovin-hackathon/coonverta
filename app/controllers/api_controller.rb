class ApiController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authenticate_request!

  def batch_invite
    permitted_users = params.permit(users: [:name, :ddd, :phone_number])

    permitted_users[:users].each do |user_param|
      User.send_invitation_code!(
        invitation_code: @store.default_invitation_code, 
        store_name: @store.name, 
        user_params: user_param)
    end

    render json: {
      success: true,
      message: "Messages scheduled to send"
    }
  end

  def sales_from_users
    begin
      sales_from_store = @store.sales.pluck(:id)
      user_sales = UserSale.where(sale_id: sales_from_store).pluck(:user_id).uniq
      users = User.find(user_sales)
    
      render json: {
        success: true,
        users: users.as_json(only: [:name, :ddd, :phone_number, :reward_points],
          methods: [:valid_sales_slug], 
          include: [:sales])
      }
    rescue => exception
      render json: {
        success: false,
        error: exception.message
      }
    end
  end

  private

  def authenticate_token!
    authenticate_or_request_with_http_token do |token, _options|
      @store = Store.find_by(api_key: token)

      if @store.present?
        token_digest = ::Digest::SHA256.hexdigest(token)
        api_auth_token_digest = ::Digest::SHA256.hexdigest(@store.api_key)

        ActiveSupport::SecurityUtils.secure_compare(token_digest, api_auth_token_digest)
      else
        self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        head :unauthorized, content_type: 'text/html'
      end

    end
	end

	# return 401 in header if token are invalid	
	def render_unauthorized
		self.headers['WWW-Authenticate'] = 'Token realm="Application"'
		head status: 401
  end
  
	# ensure that the auth will return 401 or continue with @@app
	def authenticate_request!
		authenticate_token! || render_unauthorized
  end


end