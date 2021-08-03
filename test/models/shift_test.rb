require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  def setup
    # @shift = shifts(:one)
    @shift = users(:one).shifts.build(
      date: "2021-07-31",
      start_time: "4:00:00",
      finish_time: "14:15:00",
      break_length: 10
    )
  end

  test "shift should be valid" do
    assert @shift.valid?, "shift is not valid"
  end

  test "shift must belong to a user" do
    @shift.user = nil
    assert_not @shift.valid?, "shift must belong to a user"
  end

  test "shift break length must be a number" do
    @shift.break_length = "number"
    assert_not @shift.valid?, "shift must be an integer"
  end

  test "shift start must be datetime format" do
    @shift.start_time = "number"
    assert_not @shift.valid?, "start must be in date time format"
  end

  test "shift finish must be datetime format" do
    @shift.finish_time = "number"
    assert_not @shift.valid?, "finish must be in date time format"
  end

  test "shift date must not be in future" do
    @shift.date = DateTime.tomorrow.strftime("%Y-%m-%d")
    assert_not @shift.valid?, "shift date must not be in future"
  end
end