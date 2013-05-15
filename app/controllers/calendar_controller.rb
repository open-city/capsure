class CalendarController < ApplicationController

  caches_page :index

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

    @status = params[:status]

    if @status == 'past'
      @events = cached_past_events_list
    elsif @status == 'today'
      @events = cached_today_events_list
    else
      @events = cached_future_events_list
      @status = 'upcoming'
    end
  end

  def cached_future_events_list
    Rails.cache.fetch("district_events_future_#{params[:id]}") do
      Event.where('calendar_id = ? AND start_date >= ?', params[:id], Time.now)
           .order("start_date")
    end
  end

  def cached_past_events_list
    Rails.cache.fetch("district_events_past_#{params[:id]}") do
      Event.where('calendar_id = ? AND start_date <= ?', params[:id], Time.now)
           .order("start_date DESC")
    end
  end

  def cached_today_events_list
    Rails.cache.fetch("district_events_today_#{params[:id]}") do
      Event.where('calendar_id = ? AND start_date >= ? and start_date <= ?', params[:id], Time.now.to_date, (Time.now.to_date + 1.day))
           .order("start_date")
    end
  end

end
