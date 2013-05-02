class CalendarController < ApplicationController
  def show
    @calendar = Calendar.find(params[:id])
    @events = Event.where('calendar_id = ? AND start_date >= ?', params[:id], Time.now)
                   .order("start_date")
  end
end
