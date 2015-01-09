class HomeController < ApplicationController
  
  caches_page :index

  def index
    @calendars = Calendar.where("calendars.id >= 1 AND calendars.id <= 25 AND calendars.id NOT IN (13,21)")
                           .order("calendars.id")
  end
end
