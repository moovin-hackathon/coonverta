class Store < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :api_key,:default_invitation_code

  before_create :generate_api_key

  private 

  def generate_api_key
    self.api_key = "auth-#{SecureRandom.urlsafe_base64}"
  end

end
