class HomeController < ApplicationController
  
  caches_page :index

  def index
    @events = Event.where('start_date >= ?', Time.now)
                   .order("start_date")
                   .limit(3)
  end
end
