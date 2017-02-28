class FriendsController < ApplicationController
	before_action :authenticate_user

	def index
		@friends = my_friends
	end

	def my_friends
		Friend.where({:friend1_id => session[:user_id]})
	end
	
	def show
		@friend = Friend.find(params[:id])
	end
	
	def create
		@friend = Friend.new({:friend1_id => session[:user_id], :friend2_id => params[:friend_id]})
		if @friend.save
			flash[:notice] = 'Friend added!'
		else
			flash[:notice] = 'Sorry, friend not added'
		end
		redirect_to :action => 'index'
	end

	def search
		if params[:search]
			@users = User.allPlain.search(params[:search]).order('name')
		else
			@users = User.allPlain.order('name')
		end
		#Remove self and friends
		@users = @users.reject {|user| user.id == session[:user_id]}
		@users = @users.reject {|user| my_friends.map{|f|f.friend2_id}.include? user.id}
    render 'search'
	end
end
