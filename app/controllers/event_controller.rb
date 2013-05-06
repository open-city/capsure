class EventController < ApplicationController

  require 'ri_cal'

  def show
    @calendar = Calendar.find(params[:id])
    @event = Event.find(params[:event_id])
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
      redirect_to "/district/" + params[:id] + "/event/" + @event.first.id.to_s
    end
  end

  def ical
    @event = Event.find(params[:event_id])

    calendar = RiCal.Calendar
    event = RiCal.Event
    event.description = @event[ :name ]
    event.dtstart = @event[ :start_date ].in_time_zone
    event.dtend = @event[ :end_date ].in_time_zone
    event.location = @event[ :address ]
    calendar.add_subcomponent( event )

    respond_to do |format|
      format.ics { send_data( calendar.export, :filename=> "capsure_" + @event.id.to_s + ".ics", :disposition=> "inline; filename=capsure_" + @event.id.to_s + ".ics", :type=> "text/calendar"  ) }
    end
  end
end
