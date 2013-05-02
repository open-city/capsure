CapsCalendar::Application.routes.draw do
  match '/calendar/:id' => 'calendar#show'

  match '/calendar/:id/next' => 'event#next_event'
  match '/calendar/:id/:event_id' => 'event#show'
  match '/calendar/:id/:event_id/ical' => 'event#ical'

  get '/browse' => 'calendar#index'
  get '/about' => 'home#about'

  root :to => "home#index"
end
