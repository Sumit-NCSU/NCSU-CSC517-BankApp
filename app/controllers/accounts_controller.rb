class AccountsController < ApplicationController
	before_action :authenticate_user

	def account_params
		params.require(:account).permit(:id, :status, :balance, :user_id)
	end
	
	def index
		@accounts = Account.all
	end
	
	def show
		@account = Account.find(params[:id])
	end
	
	def new
		@account = Account.new
	end
	
	def edit
		@account = Account.find(params[:id])
	end
	
	def create
		@account = Account.new(account_params)
		if @account.save
			redirect_to @account, notice: 'Account was successfully created'
		else
			render action:'new'
		end
	end
	
	def update
		@account = Account.find(params[:id])
		if @account.update_attributes(account_params)
			redirect_to @account, notice: 'Account was successfully updated.'
		else
			render action:'edit'
		end
	end
	
	def destroy
		@account = Account.find(params[:id])
		if @account.destroy
			redirect_to @account, notice: 'Account was successfully deleted.'
		else
			render action:'show'
		end
	end


end
