class ApiController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_request!

  def batch_create

  end

  def user_sales
    users_with_sales = @store.sales.user_sales.pluck(:user_id).uniq


    render json: 
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