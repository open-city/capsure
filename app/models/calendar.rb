class Calendar < ActiveRecord::Base
  attr_accessible :id, :name, :description

  def upcoming_event_count
    Event.count(:conditions => ["calendar_id = ? AND start_date >= ?", id, Time.now])
  end

  def today_event_count
    Event.count(:conditions => ["calendar_id = ? AND start_date >= ? AND start_date <= ?", id, Date.today, (Date.today + 1.day)])
  end

  def past_event_count
    Event.count(:conditions => ["calendar_id = ? AND start_date <= ?", id, Time.now])
  end
end
