require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'TestUser', email: 'testuser@gmail.com',
                     password: 'password')
    @account = Account.new(status: 'active', balance: 9.99, user: @user)
  end

  test 'account should be valid' do
    assert @account.valid?
  end

  test 'account status should be valid' do
    @account.status = 'random'
    assert_not @account.valid?
  end

end
