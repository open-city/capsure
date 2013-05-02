class HomeController < ApplicationController
  def index
    @calendars = Calendar.where("id >= 1 AND id <= 25").order("id").all
  end
end
