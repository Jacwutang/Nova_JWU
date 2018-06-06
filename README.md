
# Create a new User and new Token
```
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


