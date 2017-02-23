class TransactionsController < ApplicationController
	before_action :authenticate_user
	def transaction_params_deposit
		params.require(:transaction).permit(:to_account, :amount)
	end

	def transaction_params_withdraw
		params.require(:transaction).permit(:from_account, :amount)
	end
	def index
		@transactions = Transaction.all
	end

	def show
		@transaction = Transaction.find(params[:id])
	end

	def new
		@transaction = Transaction.new
	end

	def create
		if @transaction.save
			redirect_to @transaction, notice: 'Transaction was successful'
		else
			render action:'new'
		end
	end

	def deposit
		@transaction = Transaction.new
		render 'deposit'
	end

	def create_deposit
		@transaction = Transaction.new(transaction_params_deposit)
		@transaction.from_account = '-1'
		@transaction.txn_type = 'deposit'
		@transaction.status = 'pending'
		if @transaction.save
			flash[:notice] = 'Deposit was successful'
			redirect_to :action => 'deposit'
		else
			flash[:notice] = 'Sorry, Deposit was not successful'
			render action:'new'
		end
	end

	def borrow
		@transaction = Transaction.new
		render 'borrow'
	end

	def lend
		@transaction = Transaction.new
		render 'lend'
	end

	def withdraw
		@transaction = Transaction.new
		render 'withdraw'
	end

	def create_withdraw
		@transaction = Transaction.new(transaction_params_withdraw)
		@transaction.to_account = '-1'
		@transaction.txn_type = 'withdrawal'
		@transaction.status = 'pending'
		if @transaction.save
			flash[:notice] = 'Withdraw was successful'
			redirect_to :action => 'withdraw'
		else
			flash[:notice] = 'Sorry, Withdraw was not successful'
			render action:'new'
		end
	end

	def approve

	end
	def decline

	end
	def manage
		@transactions = Transaction.all_pending
	end

end
