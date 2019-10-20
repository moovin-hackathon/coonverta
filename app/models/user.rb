class User < ApplicationRecord
  belongs_to :store 
  has_many :user_sales
  has_many :sales, through: :user_sales

  attr_accessor :password
  before_create :encrypt_password
  before_create :generate_invitation_code
  after_create :add_point

  before_save :check_for_sale, if: :reward_points_changed?
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :ddd, :phone_number

  validates_uniqueness_of :phone_number, scope: :ddd
  
  def self.authenticate(ddd:, phone_number:, password:)
    user = find_by(ddd: ddd, phone_number: phone_number)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def generate_invitation_code
    self.invitation_code = rand.to_s[2..7]
    self.save
  end

  def add_point 
    if used_invitation_code.present?
      user = User.find_by(invitation_code: used_invitation_code)
      if user && user.actual_phase.step == 1 
        user.reward_points += 1
        user.save
      end
    end
  end

  def actual_phase
    get_phase(reward_points)
  end

  def invited_friends
    User.where(used_invitation_code: invitation_code)
  end

  def check_for_sale
    sales_to_apply = Sale.where('reward_points <= ?', reward_points).where.not(id: sales.pluck(:id))
    sales_to_apply.each { |sale| UserSale.create(user: self, sale: sale) }
  end

  def valid_sales_slug
    sales.pluck(:slug)
  end

  def self.send_invitation_code!(user_invitation_code:, user_params:, store_name: '')
    invitee_store = Store.find_by(default_invitation_code: user_invitation_code)

    if invitee_store.present?
      message = "Olá #{user_params[:name]}! #{store_name} te convida para participar do game! Passe de fase e ganhe descontos! Clique no link bit.ly/2nZZNTt e insira o código #{user_invitation_code}." 
    else
      message = "Use meu código para participar do game da #{store_name}! Acesse bit.ly/2nZZNTt e se cadastre com o código #{user_invitation_code} para participar e ganhar descontos!" 
    end
    
    phone_number = "#{user_params[:ddd]}#{user_params[:phone_number]}"
    SendNotificationWorker.perform_async(phone_number, message)
  end

  private

  def get_phase(points)
    store.game.phases.where("required_ponts <= ?", points).order(required_ponts: :desc).first
  end
end
