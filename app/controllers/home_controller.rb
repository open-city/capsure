class HomeController < ApplicationController
  def index
    @calendars = Calendar.select("calendars.id, calendars.name, count(calendars.id) as event_count")
                         .joins("LEFT JOIN events ON events.calendar_id = calendars.id")
                         .where("calendars.id >= 1 AND calendars.id <= 25")
                         .where("events.start_date >= ?", Time.now)
                         .group("calendars.id, calendars.name")
                         .order("calendars.id")
  end
end
