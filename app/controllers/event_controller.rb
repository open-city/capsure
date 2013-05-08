class EventController < ApplicationController

  require 'ri_cal'

  def show
    @calendar = Calendar.find(params[:id])
    @event = Event.where('slug = ?', params[:event_slug]).first
  end

  def next_event
    @event = Event.where('start_date >= ?', Time.now )
      .where( 'calendar_id = ? AND (details LIKE ? OR name LIKE ?)', params[:id], "%#{params[:beat_id]}%", "%#{params[:beat_id]}%")
      .order( 'start_date' )
      .limit(1)

    if @event.length == 0
      flash[:alert] = "<h4>You are in District #{params[:id]}, Beat #{params[:beat_id]}</h4> <p>Unfortunately, there are no upcoming events scheduled for your beat. Below is a list of all events for your district.</p>"
      redirect_to "/district/" + params[:id]
    else
      flash[:alert] = "<h4>You are in District #{params[:id]}, Beat #{params[:beat_id]}. This is your next CAPS meeting.</h4>"
      redirect_to "/district/" + params[:id] + "/event/" + @event.first.slug
    end
  end

  def ical
    @event = Event.where('slug = ?', params[:event_slug]).first

    puts @event.inspect

    calendar = RiCal.Calendar
    event = RiCal.Event
    event.description = @event.name
    event.dtstart = @event.start_date.in_time_zone
    unless @event.end_date.nil?
      event.dtend = @event.end_date.in_time_zone
    end
    event.location = @event.address
    calendar.add_subcomponent( event )

    respond_to do |format|
      format.ics { send_data( calendar.export, :filename=> @event.slug + ".ics", :disposition=> "inline; filename=" + @event.slug + ".ics", :type=> "text/calendar"  ) }
    end
  end
end
