class Account < ApplicationRecord
	STATUS_OPTIONS = %w(active closed)
	#attr_accessible :account_number, :balance, :status, :users, :to_transactions, :from_transactions
	#attr_accessor :account_number, :balance, :status, :users
	belongs_to :user
	has_many :received_transactions, :class_name => 'Transaction', :foreign_key => 'received_transactions', :primary_key => 'to_account'
	has_many :sent_transactions, :class_name => 'Transaction', :foreign_key => 'sent_transactions', :primary_key => 'from_account'
	
	before_create :generate_account_number
	
	validates :balance, :presence => true
	validates :status, :presence => true
	validates :status, :inclusion => {:in => STATUS_OPTIONS}
	
	private def generate_account_number
	self.account_number = loop do
		random_number = rand(100000000...1000000000)
		break random_number unless Account.exists?(account_number: random_number)
	end
	end
	
	def get_pending_sent_transactions
		self.sent_transactions.where(:approval_status => 'pending')
	end
	
	def get_pending_received_transactions
		self.received_transactions.where(:approval_status => 'pending')
	end
end
