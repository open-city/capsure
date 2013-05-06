class CalendarController < ApplicationController

  caches_page :index
  caches_page :show

  def index
    @calendars = Calendar.select("calendars.id, calendars.name, count(calendars.id) as event_count")
                         .joins("LEFT JOIN events ON events.calendar_id = calendars.id")
                         .where("calendars.id >= 1 AND calendars.id <= 25")
                         .where("events.start_date >= ?", Time.now)
                         .group("calendars.id, calendars.name")
                         .order("calendars.id")
  end

  def show
    @calendar = Calendar.find(params[:id])
    @events = Event.where('calendar_id = ? AND start_date >= ?', params[:id], Time.now)
                   .order("start_date")
  end
end
