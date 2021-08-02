module ShiftsHelper

  def display_date(shift)
    shift.start.strftime("%m/%d/%Y")
  end

  def display_time(datetime_obj)
    datetime_obj.strftime("%l:%M %p")
  end

  def hours_worked(shift)
    break_hours = shift.break_length/60.to_f
    TimeDifference.between(shift.start, shift.finish).in_hours - break_hours
  end

  def shift_cost(shift, organisation)
    hours_worked(shift) * organisation.hourly_rate
  end
end