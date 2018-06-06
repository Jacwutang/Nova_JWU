class TableUser < ApplicationRecord
  validates :email, presence: true


  has_one :token,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: 'TableUserAuthorizationToken'



  #Find by email
  def self.find_by_credentials(email)
    user = TableUser.find_by_email(email)
    return nil if user.nil?

    return user
  end

  def self.reset_session_token!
    
  end


end
