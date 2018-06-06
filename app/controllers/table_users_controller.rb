class TableUsersController < ApplicationController
  def create
    #Creating a user.

    @user = User.new(params[:email])

    # If user successfully created,
    if @user.save
      #Generate a unique token and store in authorization table

      token = UserAuthorizationToken.generate_auth_token

      @token = UserAuthorizationToken.new(token,@user.id)

      if @token.save

      else


      end

      #send the token to the client.


      #Store token in browser or somewhere else.


    else


    end
  end

  def show

  end



  private


  # def user_params
  #   params.require(:user).permit(:email)
  # end

end
