# User model validations and associations
```ruby 
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



end
```

# Token model validations and associations
```ruby
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
```
# Create a new User and new Token

```ruby
class TableUsersController < ApplicationController
  def create
    #Creating a user.

    @user = User.new(user_params)

    # If user successfully created,
    if @user.save
      #Generate a unique token and store in authorization table

      token_string = UserAuthorizationToken.generate_auth_token

      @token = UserAuthorizationToken.new(token: token_string, user_id: @user.id)

      if @token.save
        #send the token, email, and user id to the client.

        login(@user)

        render json: {@user.email, @user.id, token: token}

        #client can then store the token in localStorage or use rails session
      end
    end

  end
```




