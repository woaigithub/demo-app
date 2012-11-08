module SessionsHelper

  def sign_in(user)
    cookies.permanent[:token]=user.remember_token
    current_user=user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user=nil
    cookies.delete(:token)
  end

  def current_user=(user)
    @current_user=user
  end

  def current_user
      @current_user ||= User.find_by_remember_token(cookies[:token])
  end

  def current_user?(user)
    user==current_user
  end


end
