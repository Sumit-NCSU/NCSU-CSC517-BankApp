class SessionsController < ApplicationController
  before_action :authenticate_user, :only => [:home, :profile, :settings]
  before_action :save_login_state, :only => [:new, :create]

  def new
    render 'new'
  end

  def create
    authorized_user = User.authenticate(params[:login_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome, you are logged in as #{authorized_user.name}"
      flash[:color] = 'valid'
      redirect_to :controller => 'users', :action => 'index'
    else
      flash[:notice] = 'Invalid Username or Password'
      flash[:color] = 'invalid'
      redirect_to :controller => 'sessions', :action => 'create'
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to :action => 'create'
  end

  def home
    redirect_to 'session/index'
  end

  def profile

  end

  def setting

  end
end
