namespace :import do

  desc "Import all calendars and events"
  task :all => :environment do
    Rake::Task["import:community_calendars"].invoke
    Rake::Task["import:community_events"].invoke
  end
  
  desc "Fetch all calendars from CPD communityCalendar"
  task :community_calendars => :environment do
    require 'open-uri'
    require 'json'
    # Calendar.delete_all

    offset = 0
    calendar_endpoints = JSON.parse(open("http://api1.chicagopolice.org/clearpath/api/1.0/communityCalendar?offset=#{offset}").read)

    while (calendar_endpoints != []) do
      calendar_endpoints.each do |c|

        calendar = Calendar.find_or_create_by_id(c['calendarId'])
        calendar.name = c['name']
        calendar.description = c['description']
        calendar.save!
        puts "importing #{calendar.name}"
      end

      offset = offset + 10
      puts "reading page #{offset}"
      calendar_endpoints = JSON.parse(open("http://api1.chicagopolice.org/clearpath/api/1.0/communityCalendar?offset=#{offset}").read)
    end

    cal_count = Calendar.count
    puts "imported #{cal_count} calendars"

    puts 'Done!'
  end

  desc "Fetch all events from CPD communityCalendar"
  task :community_events => :environment do
    require 'open-uri'
    require 'json'
    # Event.delete_all

    offset = 0
    event_endpoints = JSON.parse(open("http://api1.chicagopolice.org/clearpath/api/1.0/communityCalendar/events?offset=#{offset}").read)

    while (event_endpoints != []) do
      event_endpoints.each do |e|

        event = Event.find_or_create_by_start_date_and_name(:start_date => e['eventStartDate'], :name => e['eventName'])
        event.calendar_id = e['calendarId']
        event.start_date = e['eventStartDate']
        event.end_date = e['eventEndDate']
        event.name = e['eventName']
        event.details = e['eventDetails']
        event.url = e['eventUrl']
        event.contact_details = e['contactDetails']
        event.location = e['location']
        event.modified_date = e['modifiedDate']
        event.save!
        puts "importing #{event.name}"
      end

      offset = offset + 10
      puts "reading page #{offset}"
      event_endpoints = JSON.parse(open("http://api1.chicagopolice.org/clearpath/api/1.0/communityCalendar/events?offset=#{offset}").read)
    end

    event_count = Event.count
    puts "imported #{event_count} events"

    puts 'Done!'
  end
end