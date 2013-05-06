CapsCalendar::Application.routes.draw do
  match '/district/:id' => 'calendar#show'

  match '/district/:id/beat/:beat_id/next' => 'event#next_event'
  match '/district/:id/event/:event_id' => 'event#show'
  match '/district/:id/event/:event_id/ical' => 'event#ical'

  get '/browse' => 'calendar#index'
  get '/about' => 'home#about'

  root :to => "home#index"
end
