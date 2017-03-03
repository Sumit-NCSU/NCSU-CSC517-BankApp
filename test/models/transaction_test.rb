require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = Transaction.new(txn_type: 'deposit', amount: 9.99, start_date: '2017-02-19 03:15:03',
        effective_date: '2017-02-19 03:15:03', status: 'pending')
  end

  test 'transaction should be valid' do
    assert @transaction.valid?
  end

  test 'transaction type should be valid' do
    @transaction.txn_type = 'random'
    assert_not @transaction.valid?
  end

  test 'transaction status should be valid' do
    @transaction.status = 'random'
    assert_not @transaction.valid?
  end

end
