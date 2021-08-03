require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @user.password = ("123456") # Ensures password is not nil
  end

  test "user should be valid" do
    assert @user.valid?, "user is not valid"
  end

  test "password must be at least 6 characters long" do
    @user.password = "12345"
    assert_not @user.valid?, "password is not at least 6 characters"
  end

  test "name must be present" do
    @user.name = " "
    assert_not @user.valid?, "name is empty string"
  end

  test "email must be present" do
    @user.email = " "
    assert_not @user.valid?, "email is empty string"
  end

  test "email must be unique" do
    @user.email = "user@company.com"
    new_user = User.new(@user.attributes)
    assert_not new_user.valid?, "email must be unique"
  end

  test "email should be valid address" do
    @user.email = "emailaddress"
    assert_not @user.valid?, "email must be valid address"
  end
end
