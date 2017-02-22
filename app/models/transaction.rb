class Transaction < ApplicationRecord
  belongs_to :from_account, :foreign_key => 'from_account', :class_name => 'Account'
  belongs_to :to_account, :foreign_key => 'to_account', :class_name => 'Account'

  TYPES = %w(deposit withdrawal send borrow)
  STATUS_OPTIONS = %w(pending approved)
  validates :txn_type, :inclusion => {:in => TYPES}

  def self.all_pending
    self.where(:approval_status => 'pending')
  end
end
