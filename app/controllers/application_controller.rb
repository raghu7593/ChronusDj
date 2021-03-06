class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :login_required

  def login_required
    redirect_to root_path and return unless current_user
  end

  private
  def current_user
    @current_user ||= Member.find_by_id(session[:member_id]) if session[:member_id]
  end

  def logged_in_super_user?
    !!session[:super_user]
  end
  helper_method :current_user
  helper_method :logged_in_super_user?
end
