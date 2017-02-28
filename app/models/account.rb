class Account < ApplicationRecord
	STATUS_OPTIONS = %w(active closed)
	#attr_accessible :balance, :status, :users, :to_transactions, :from_transactions
	#attr_accessor balance, :status, :users
	belongs_to :user
	has_many :received_transactions, class_name: "Transaction",
					 foreign_key: "to_account"
	has_many :sent_transactions, class_name: "Transaction",
					 foreign_key: "from_account"
	
	before_create :generate_id
	
	validates :balance, :presence => true
	validates :status, :presence => true
	validates :status, :inclusion => {:in => STATUS_OPTIONS}
	
	private def generate_id
	self.id = loop do
		random_number = rand(100000000...1000000000)
		break random_number unless Account.exists?(id: random_number)
	end
	end
	
	def get_pending_sent_transactions
		self.sent_transactions.where(:approval_status => 'pending')
	end
	
	def get_pending_received_transactions
		self.received_transactions.where(:approval_status => 'pending')
	end

	def add_balance (amount)
		self.balance = self.balance + amount;
	end

	#TODO: check for overdraft
	def subtract_balance (amount)
		self.balance = self.balance - amount;
	end
end
