CapsCalendar::Application.routes.draw do
  match '/calendar/:id' => 'calendar#show'
  match '/calendar/:id/:event_id' => 'event#show'

  match '/calendar/:id/:event_id/ical' => 'event#ical'

  root :to => "home#index"
end
