class User < ApplicationRecord
  belongs_to :store 
  has_many :user_sales
  has_many :sales, through: :user_sales

  attr_accessor :password
  before_create :encrypt_password
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

  def add_point 
    if used_invitation_code.present?
      user = User.find(invitation_code: used_invitation_code)
      if user.actual_phase.step == 1 
        user.reward_points += 1
        user.save
      end
    end
  end

  def actual_phase
    get_phase(reward_points)
  end

  def invited_friends
    User.where(used_invitation_code: user.invitation_code)
  end

  def check_for_sale
    sales_to_apply = Sale.where('reward_points <= ?', reward_points).where.not(id: sales.pluck(:id))
    sales_to_apply.each { |sale| UserSale.create(user: self, sale: sale) }
  end

  def valid_sales_slug
    sales.pluck(:slug)
  end

  private 

  def get_phase(points)
    store.game.phases.where("required_ponts <= ?", points)
                     .order(required_ponts: :desc).first
  end

end
