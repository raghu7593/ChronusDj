class SessionsController < ApplicationController
  def new
  end

  def new_super_user
  end

  def create
    member = Member.from_omniauth(env["omniauth.auth"])
    session[:member_id] = member.id
    redirect_to root_url
  end

  def create_super_user
    if params[:super_user] == ""
      session[:super_user] = true
      redirect_to root_url
    else
      redirect_to sl_path
    end
  end

  def destroy
    if session[:super_user]
      session[:super_user] = nil
    else
      session[:member_id] = nil
    end
    redirect_to root_url
  end

  def failure
    redirect_to root_url
  end
end