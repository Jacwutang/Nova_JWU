class TableUserAuthorizationToken < ApplicationRecord
  validates :token, :user_id, presence: true


  belongs_to :user,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: 'TableUser'

  def self.generate_auth_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.save_token
    @user = TableUser.find_by_credentials(params[:email])

    token = TableUserAuthorizationToken.generate_auth_token

    @token = TableUserAuthorizationToken.new(token,@user.id)

    if @token.save
      print "success"
    else
      print "error"
    end

  end

end
