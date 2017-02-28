require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:one)
    @user = users(:two)
  end
  test 'should get new user path' do
    get new_user_path
    assert_response :success
  end
end
