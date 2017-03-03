class TransactionsController < ApplicationController
	before_action :authenticate_user
	def transaction_params_deposit
		params.require(:transaction).permit(:to_account_id, :amount)
	end
	def transaction_params_withdraw
		params.require(:transaction).permit(:from_account_id, :amount)
	end
	def transaction_params_borrow_lend
		params.require(:transaction).permit(:from_account_id, :to_account_id, :amount)
	end
	def index
		@transactions = Transaction.where('from_account_id in (select id from accounts where user_id = ?) or to_account_id in (select id from accounts where user_id = ?)', session[:user_id], session[:user_id]).order(:status).reverse_order
	end

	def show
		@transaction = Transaction.find(params[:id])
	end

	#Cancel transaction not working
	def destroy
		@transaction = Transaction.find(params[:id])
		if @transaction.destroy
			redirect_to :action => :index, notice: 'Transaction was successfully cancelled.'
		else
			redirect_to :action => :index, notice: 'Unable to cancel transaction.'
		end
	end

	def set_accounts
		authUser = User.find(session[:user_id])
		friends = authUser.friends.map {|u| u.id}
		@friends_accounts = Account.select{|a|friends.include? a.user_id }
		@my_accounts = Account.select{|a| a.user_id == authUser.id }
	end

	def deposit
		@transaction = Transaction.new
		render 'deposit'
	end

	def create_deposit
		@transaction = Transaction.new(transaction_params_deposit)
		@transaction.from_account_id = nil
		@transaction.txn_type = 'deposit'
		@transaction.status = 'pending'
		if @transaction.save
			flash[:notice] = 'Deposit was requested'
		else
			flash[:notice] = 'Sorry, Deposit was not requested'
		end
		redirect_to :action => 'deposit'
	end

	def withdraw
		@transaction = Transaction.new
		render 'withdraw'
	end

	def create_withdraw
		msg = nil
		@transaction = Transaction.new(transaction_params_withdraw)
		@transaction.to_account_id = nil
		@transaction.txn_type = 'withdrawal'
		if transaction_params_withdraw[:amount].to_d > 1000
			@transaction.status = 'pending'
			msg = 'Withdrawal was requested'
		else
			msg = @transaction.approve(User.find(session[:user_id]).email)
		end
		if @transaction.save
			flash[:notice] = msg
		else
			flash[:notice] = 'Sorry, withdrawal was not requested'
		end
		redirect_to :action => 'withdraw'
	end

	def borrow
		@transaction = Transaction.new
		set_accounts
		render 'borrow'
	end

	def create_borrow
		@transaction = Transaction.new(transaction_params_borrow_lend)
		@transaction.txn_type = 'borrow'
		if @transaction.approve(User.find(session[:user_id]).email)
				flash[:notice] = 'Borrow was successful'
			else
				flash[:notice] = 'Sorry, borrow was not successful'
			end
			redirect_to :action => 'borrow'
	end

	def lend
		@transaction = Transaction.new
		set_accounts
		render 'lend'
	end

	def create_lend
		@transaction = Transaction.new(transaction_params_borrow_lend)
		@transaction.txn_type = 'send'
		if @transaction.approve(User.find(session[:user_id]).email)
			flash[:notice] = 'Send successful'
		else
			flash[:notice] = 'Sorry, lend was not successful'
		end
		redirect_to :action => 'lend'
	end

	def manage
		@transactions = Transaction.all_pending
	end

	def approve
		msg = Transaction.find(params[:txn_id]).approve(User.find(session[:user_id]).email)
		if msg
			flash[:notice] = msg
			redirect_to :action => 'manage'
		end
	end

	def decline
		if Transaction.find(params[:txn_id]).decline(User.find(session[:user_id]).email)
			flash[:notice] = 'Transaction declined'
			redirect_to :action => 'manage'
		end
	end

end
