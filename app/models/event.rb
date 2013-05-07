class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :name, :details, :url, :contact_details, :location, :modified_date

  def start_date_formatted
    start_date.strftime("%b #{start_date.day.ordinalize}, %Y")
  end

  def start_date_formatted_full
    start_date.strftime("%A, %b #{start_date.day.ordinalize}, %Y")
  end

  def start_date_formatted_simple
    start_date.strftime("%b #{start_date.day.ordinalize}")
  end

  def start_time
    start_date.strftime("%l:%M %p").downcase
  end

  def end_time
    if end_date.nil?
      ""
    else
      end_date.strftime(" - %l:%M %p").downcase
    end
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
      encoded_location = address.gsub(/\n/, ' ').gsub(/ /, '+')
      "https://maps.google.com/maps?f=d&hl=en&geocode=&daddr=#{encoded_location}"
    end
  end

  def address
    addr = parse_address[0]
    if addr.nil? or addr == ''
      ""
    elsif addr.downcase.include? 'chicago'
      addr
    else
      "#{addr} Chicago, IL"
    end
  end

  def location_details
    parse_address[1]
  end

  private
  def parse_address
    # logic for splitting up location and location_details
    this_location = ''
    this_location_details = ''

    unless location.nil?
      location_lines = location.split(/\n/)
      location_lines.each do |l|
        if l.match(/\d/).nil? or l.downcase.include? 'district'
          this_location_details = l
        else
          this_location = l
        end
      end

      if this_location == ''
        return [this_location_details , ''] # parsing failed, just return the first line as the address
      end
    end

    [this_location, this_location_details]
  end

end
