module ShiftsHelper

  def display_date(shift)
    shift.start.strftime("%m/%d/%Y")
  end

  def display_time(datetime_obj)
    datetime_obj.strftime("%l:%M %p")
  end

  def form_date(shift)
    shift.try(:start).try(:to_date)
  end

  def form_start_time(shift)
    shift.try(:start).try(:strftime, "%T.%L")
  end

  def form_finish_time(shift)
    shift.try(:finish).try(:strftime, "%T.%L")
  end

  def hours_worked(shift)
    break_hours = shift.break_length/60.to_f
    TimeDifference.between(shift.start, shift.finish).in_hours - break_hours
  end

  def shift_cost(shift, organisation)
    cost = hours_worked(shift) * organisation.hourly_rate
    number_to_currency(cost)
  end
end