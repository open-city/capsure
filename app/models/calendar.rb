class Calendar < ActiveRecord::Base
  attr_accessible :id, :name, :description

  def event_count
    Event.count(:conditions => ["calendar_id = ? AND start_date >= ?", id, Time.now])
  end
end
