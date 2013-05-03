class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :name, :details, :url, :contact_details, :location, :modified_date

  def start_date_formatted
    start_date.strftime("%b %d, %Y")
  end

  def start_date_cal
    start_date.strftime("%Y%m%dT%H%M%S")
  end

  def end_date_cal
    if end_date.nil?
      start_date_cal
    else
      end_date.strftime("%Y%m%dT%H%M%S")
    end
  end

  def directions_link
    if location.nil?
      ""
    else
      encoded_location = location.gsub(/\/n/, ' ').gsub(/ /, '+')
      "https://maps.google.com/maps?f=d&hl=en&geocode=&daddr=#{encoded_location}+Chicago,+IL"
    end
  end
end
