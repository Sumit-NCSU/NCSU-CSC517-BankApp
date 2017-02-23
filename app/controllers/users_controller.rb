class UsersController < ApplicationController
  before_action :save_login_state, :only => [:new, :create]

	def index_users
		@users = User.where({is_admin:false})
		@showing_admins = false
		render 'index'
	end

	def index_admins
		@users = User.where({is_admin:true})
		@showing_admins = true
		render 'index'
	end
	
	def show
		@user = User.find(params[:id])
	end
	
	def new
		@user = User.new
	end

	def new_admin
		@admin = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = 'User created successfully'
			flash[:color] = 'valid'
		else
			flash[:notice] = 'User not created'
			flash[:color] = 'invalid'
		end
		redirect_to :controller => 'sessions', :action => 'create'
	end

	def create_admin
		@admin = User.new(user_params)
		@admin.is_admin = true
		if @admin.save
			flash[:notice] = 'User created successfully'
			flash[:color] = 'valid'
		else
			flash[:notice] = 'User not created'
			flash[:color] = 'invalid'
		end
		redirect_to :controller => 'users', :action => 'index_admins'
	end


	# GET /users/1/edit
	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to users_path, notice: 'User profile successfully updated.'
		else
			render action:'edit'
		end

	end

	def destroy
		@admin = User.find(params[:id])
		#if !@admin.is_admin redirect_to @account, notice: 'Account was successfully deleted.'
		if @admin.destroy
			redirect_to '/admins', notice: 'Admin was successfully deleted.'
		else
			render action:'index_admins' #TODO: add error printing
		end
	end

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end
end
