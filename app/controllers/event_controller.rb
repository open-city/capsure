class EventController < ApplicationController

  require 'ri_cal'

  def show
    @calendar = Calendar.find(params[:id])
    @event = Event.find(params[:event_id])
  end

  def next_event
    @event = Event.where('start_date >= ?', Time.now )
      .where( :calendar_id => params[:id] )
      .order( 'start_date' )
      .limit(1)
      .first
    redirect_to "/calendar/" + params[:id] + "/" + @event.id.to_s
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
