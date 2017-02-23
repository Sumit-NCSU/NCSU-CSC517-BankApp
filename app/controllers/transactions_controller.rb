class TransactionsController < ApplicationController
	before_action :authenticate_user

	def index
		@transactions = Transaction.all
	end
	
	def show
		@transaction = Transaction.find(params[:id])
	end
	
	def new
		@transaction = Transaction.new
	end

	def deposit
		@transaction = Transaction.new
		render 'deposit'
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
	
	def approve

  end
  def decline

  end
  def manage
    @transactions = Transaction.all_pending
  end

end
