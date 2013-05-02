class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :name, :details, :url, :contact_details, :location, :modified_date
end
