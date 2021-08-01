require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  def setup
    @shift = shifts(:one)
  end

  test "shift should be valid" do
    assert @shift.valid?, "shift is not valid"
  end

  test "shift must belong to a user" do
    @shift.user = nil
    assert_not @shift.valid?, "shift must belong to a user"
  end

  #how can I test for more than one type of failure?
  # Ex: "string", 10.00033 - does integer datatype adjust decimals to ints?
  test "shift break length must be a number" do
    @shift.break_length = "number"
    assert_not @shift.valid?, "shift must be an integer"
  end

  test "shift start must be datetime format" do
    @shift.start = "number"
    assert_not @shift.valid?, "finish must be in date time format"
  end

  test "shift finish must be datetime format" do
    @shift.finish = "number"
    assert_not @shift.valid?, "start must be in date time format"
  end

  test "shift date must not be in future" do
    @shift.start = DateTime.tomorrow
    assert_not @shift.valid?, "shift date must not be in future"
  end
end
