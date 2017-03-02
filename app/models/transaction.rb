class Transaction < ApplicationRecord

  belongs_to :from_account, :class_name => 'Account', optional:true
  belongs_to :to_account, :class_name => 'Account',  optional:true

  TYPES = %w(deposit withdrawal send borrow)
  STATUS_OPTIONS = %w(pending approved declined)
  validates :txn_type, :inclusion => {:in => TYPES}
  validates :status, :inclusion => {:in => STATUS_OPTIONS}

  def self.all_pending
    self.where(:status => 'pending')
  end

  def approve
    to_account = nil
    from_account = nil
    if self.to_account_id != nil
      to_account = Account.find(self.to_account_id)
    end
    if self.from_account_id != nil
      from_account = Account.find(self.from_account_id)
    end
    if txn_type != 'withdrawal'
        to_account.add_balance amount.to_d
        to_account.save
    end
    if txn_type != 'deposit'
        from_account.subtract_balance amount.to_d
        from_account.save
    end
    self.status = 'approved'
    self.effective_date = DateTime.now
    self.save
  end

  def decline
    self.status = 'declined'
    self.save
  end

end


