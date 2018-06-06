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
