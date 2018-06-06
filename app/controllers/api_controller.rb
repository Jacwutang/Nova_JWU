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
