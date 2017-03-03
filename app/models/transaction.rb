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

  def approve(userEmail)
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
    negative_balance = false
    if txn_type != 'deposit'
        negative_balance = from_account.subtract_balance amount.to_d
        from_account.save
    end
    if negative_balance == true
      decline(userEmail)
      return 'Withdrawal was declined because of insufficient funds!'
    else
      self.status = 'approved'
      self.effective_date = DateTime.now
      self.save
      msg = nil
      if txn_type.to_s.downcase == 'withdrawal'
        msg = "Withdrawal of amount #{amount} was #{self.status} from account #{from_account_id} on #{self.effective_date}!"
      elsif txn_type.to_s.downcase == 'deposit'
        msg = "Deposit of amount #{amount} was #{self.status} to account #{to_account_id} on #{self.effective_date}!"
      elsif txn_type.to_s.downcase == 'send'
        msg = "Sending amount #{amount} was #{self.status} from account #{from_account_id} to account #{to_account_id} on #{self.effective_date}!"
      elsif txn_type.to_s.downcase == 'borrow'
        msg = "Borrowing amount #{amount} was #{self.status} from account #{from_account_id} to account #{to_account_id} on #{self.effective_date}!"
      end
      UserMailer.sendMail(userEmail,msg).deliver
      return msg
    end
  end

  def decline(userEmail)
    self.status = 'declined'
    self.save
    if txn_type.to_s.downcase == 'withdrawal'
      msg = "Withdrawal of amount #{amount} was #{self.status} from account #{from_account_id} on #{self.effective_date}!"
    elsif txn_type.to_s.downcase == 'deposit'
      msg = "Deposit of amount #{amount} was #{self.status} to account #{to_account_id} on #{self.effective_date}!"
    elsif txn_type.to_s.downcase == 'send'
      msg = "Sending amount #{amount} was #{self.status} from account #{from_account_id} to account #{to_account_id} on #{self.effective_date}!"
    elsif txn_type.to_s.downcase == 'borrow'
      msg = "Borrowing amount #{amount} was #{self.status} from account #{from_account_id} to account #{to_account_id} on #{self.effective_date}!"
    end
    UserMailer.sendMail(userEmail,msg).deliver
  end

end


