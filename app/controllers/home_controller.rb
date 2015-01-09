class HomeController < ApplicationController
  
  caches_page :index

  def index
    @calendars = Calendar.where("calendars.id >= 1 AND calendars.id <= 25")
                           .order("calendars.id")
  end
end
