class Transaction < ApplicationRecord
  belongs_to :from_account, :foreign_key => 'from_account', :class_name => 'Account', :primary_key => 'account_number'
  belongs_to :to_account, :foreign_key => 'to_account', :class_name => 'Account', :primary_key => 'account_number'

  TYPES = %w(deposit withdrawal send borrow)
  STATUS_OPTIONS = %w(pending approved)
  validates :txn_type, :inclusion => {:in => TYPES}

  def self.all_pending
    self.where(:approval_status => 'pending')
  end
end
