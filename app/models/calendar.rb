class Calendar < ActiveRecord::Base
  attr_accessible :id, :name, :description

  def upcoming_event_count
    Event.count(:conditions => ["calendar_id = ? AND start_date >= ?", id, Time.now])
  end

  def today_event_count
    Event.count(:conditions => ["calendar_id = ? AND start_date >= ? AND start_date <= ?", id, Date.today, (Date.today + 1.day)])
  end

  def past_event_count
    Event.count(:conditions => ["calendar_id = ? AND start_date <= ?", id, Time.now])
  end

  def friendly_name

    districts = {
      1 => 'Central',
      2 => 'Wentworth',
      3 => 'Grand Crossing',
      4 => 'South Chicago',
      5 => 'Calumet',
      6 => 'Gresham',
      7 => 'Englewood',
      8 => 'Chicago Lawn',
      9 => 'Deering',
      10 => 'Ogden',
      11 => 'Harrison',
      12 => 'Near West',
      14 => 'Shakespeare',
      15 => 'Austin',
      16 => 'Jefferson Park',
      17 => 'Albany Park',
      18 => 'Near North',
      19 => 'Town Hall',
      20 => 'Lincoln',
      22 => 'Morgan Park',
      24 => 'Rogers Park',
      25 => 'Grand Central'
    }

    return districts[id]

  end
end
