class Shift < ApplicationRecord
  attr_accessor :date, :start_time, :finish_time, :overnight
  belongs_to :user
  
  before_validation :set_start_datetime, :set_finish_time
  validates :break_length, numericality: { only_integer: true }
  validates_datetime :start
  validates_datetime :finish
  validates_date :start, on_or_before: :today

  scope :newest, -> {order(start: :desc)}

  def overnight
   self[:start].day < self[:finish].day
  end

  private 
  def set_start_datetime
    self[:start] = date + " " + start_time
  end

  def set_finish_time
    if finish_time < start_time
      # Increase date by one for overnight shift
      next_day = Date.parse(date) + 1
      self[:finish] = next_day.to_s + " " + finish_time
    else
      self[:finish] = date + " " + finish_time
    end
  end
end