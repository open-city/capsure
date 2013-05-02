class EventController < ApplicationController
  def show
    @calendar = Calendar.find(params[:id])
    @event = Event.find(params[:event_id])
  end
end
