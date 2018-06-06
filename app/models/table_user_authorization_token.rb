class TableUserAuthorizationToken < ApplicationRecord
  validates :token, :user_id, presence: true


  belongs_to :user,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: 'TableUser'

  def self.generate_auth_token
    SecureRandom::urlsafe_base64(16)
  end

  

end
