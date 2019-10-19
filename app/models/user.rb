class User < ApplicationRecord
  attr_accessor :password
  before_save :encrypt_password
  
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
end
