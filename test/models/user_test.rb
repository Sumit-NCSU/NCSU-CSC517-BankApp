require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'TestUser', email: 'testuser@gmail.com',
                     password: 'password')
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'user name should not be blank' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'user email should not be blank' do
    @user.email = '   '
    assert_not @user.valid?
  end

  test 'user email addresses should not be duplicate' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = ' '
    assert_not @user.valid?
  end

  test 'password should not be too short' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'password should not be too long' do
    @user.password = @user.password_confirmation = 'a' * 57
    assert_not @user.valid?
  end

end
