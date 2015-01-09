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
    Event.delete_all

    offset = 0
    event_endpoints = JSON.parse(open("http://api1.chicagopolice.org/clearpath/api/1.0/communityCalendar/events?offset=#{offset}").read)

    while (event_endpoints != []) do
      event_endpoints.each do |e|

        event = Event.where(:start_date => e['eventStartDate'], :name => e['eventName']).first_or_create!
        # puts event.inspect
        event.calendar_id = e['calendarId']
        event.start_date = e['eventStartDate']
        event.end_date = e['eventEndDate']
        event.name = e['eventName']
        event.details = e['eventDetails']
        event.url = e['eventUrl']
        event.contact_details = e['contactDetails']
        event.location = e['location']
        event.modified_date = e['modifiedDate']

        event.slug = to_slug "#{event.start_date.strftime('%m %d %Y %l %M %p')} #{event.calendar_id.ordinalize} #{event.name}"
        event.save
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

  def to_slug s
    #strip the string
    ret = s.strip.downcase

    #blow away apostrophes
    ret.gsub! /['`.]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
     ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  

     #convert double underscores to single
     ret.gsub! /_+/,"_"

     #strip off leading/trailing underscore
     ret.gsub! /\A[_\.]+|[_\.]+\z/,""

     ret
  end

end