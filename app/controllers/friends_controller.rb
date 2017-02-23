class FriendsController < ApplicationController
	before_action :authenticate_user

	def index
		@friends = Friend.all
	end
	
	def show
		@friend = Friend.find(params[:id])
	end
	
	def new
	end

	def search
		if params[:search]
			@users = User.search(params[:search]).order('name')
		else
			return nil
    end
    redirect_to 'friends/search'
	end
end
