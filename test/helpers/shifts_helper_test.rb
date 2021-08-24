require 'test_helper'

class ShiftsHelperTest < ActionView::TestCase
  setup do
    @shift = shifts(:one)
    @organisation = organisations(:aquaco)
    @new_shift = users(:one).shifts.build
  end

  test 'should display shift date in MM/DD/YYYY format' do
    assert_equal "07/31/2021", display_date(@shift)
  end

  test 'should display time in HH:MM AM/PM format, with leading zero removed from hour if present' do
    assert_equal " 2:00 PM", display_time(@shift.start)
  end

  test 'should format shift dateTime object as date only if present' do
    assert_equal DateTime.new(2021, 7, 31), form_date(@shift)
  end

  test 'new/edit form should not break if start or finish time is not present for shift object' do
    assert_nothing_raised do
      form_date(@new_shift)
    end
  end

  test 'should format shift start time as 24-hr time with milliseconds' do
    assert_equal "14:00:00.000", form_start_time(@shift)
  end

  test 'should format shift finish time as 24-hr time with milliseconds' do
    assert_equal "18:45:00.000", form_finish_time(@shift)
  end

  test 'should return hours worked per shift as integer' do
    assert_equal 4.5, hours_worked(@shift)
  end

  test 'should calculate shift cost based on hourly rate at organisation' do
    assert_equal "$47.21", shift_cost(@shift, @organisation)
  end
end