class UsersController < ApplicationController
  before_action :save_login_state, :only => [:new, :create]

	def index_users
		@users = User.where({is_admin:false})
		render 'index_users'
	end

	def index_admins
		@admins = User.where({is_admin:true})
		render 'index_admins'
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
			flash[:notice] = 'User was created successfully.'
			flash[:color] = 'valid'
		else
			flash[:notice] = 'User not created.'
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
		@user = User.find(params[:id])
		if @user.destroy
			if @user.is_admin
				redirect_to '/admins', notice: 'Admin was successfully deleted.'
			else
				redirect_to '/users', notice: 'User was successfully deleted.'
			end
		else
			render action:'index_admins' #TODO: add error printing
		end
	end

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end
end
