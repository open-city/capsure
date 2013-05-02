class EventController < ApplicationController

  require 'ri_cal'

  def show
    @calendar = Calendar.find(params[:id])
    @event = Event.find(params[:event_id])
  end

  def ical
    @event = Event.find(params[:event_id])

    calendar = RiCal.Calendar
    event = RiCal.Event
    event.description = @event[ :name ]
    event.dtstart = @event[ :start_date ].to_datetime
    event.dtend = @event[ :end_date ].to_datetime
    event.location = @event[ :location ] + ", Chicago, IL"
    calendar.add_subcomponent( event )

    respond_to do |format|
      format.ics { send_data( calendar.export, :filename=> "capsure_" + @event.id.to_s + ".ics", :disposition=> "inline; filename=capsure_" + @event.id.to_s + ".ics", :type=> "text/calendar"  ) }
    end
  end
end
