class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :name, :details, :url, :contact_details, :location, :modified_date

  def start_date_formatted
    start_date.strftime("%b %d, %Y")
  end

  def start_date_cal
    start_date.strftime("%Y%m%dT%H%M%S")
  end

  def end_date_cal
    end_date.strftime("%Y%m%dT%H%M%S")
  end
end
