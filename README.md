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

# Api controller

### 1) before any other methods, require that a user is logged in.
### 2) If logged in, proceed with controller actions (unfinished)

```ruby
class ApiController < ApplicationController
  #before accessing other  API controller methods, require login
  before_action :require_login

  private

  def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
      redirect_to "/login"
  end





end
```

# Applications Controller
### 1) Use Session object to verify a user.
```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def logged_in?
    !!current_user
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= TableUserAuthorizationToken.find_by(token: session[:token])
  end

  def login(user)
    @token_obj = TableUserAuthorizationToken.find_by(user_id: user.id)
    session[:token] = @token_obj.token
    @current_user = user
  end


end
```




