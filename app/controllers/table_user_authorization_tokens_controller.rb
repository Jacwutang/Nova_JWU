class TableUserAuthorizationTokensController < ApplicationController
  def create
    @user = TableUser.find_by_credentials(:email)

    if @user

    else

  end



  private
  # def user_params
  #   params.require(:user).permit(:email)
  # end

end
