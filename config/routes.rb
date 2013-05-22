CapsCalendar::Application.routes.draw do
  match '/district/:id(/:status)' => 'calendar#show'

  match '/district/:id/beat/:beat_id/next' => 'event#next_event'
  match '/district/:id/event/:event_slug' => 'event#show', :as => :event
  match '/district/:id/event/:event_slug/ical' => 'event#ical'

  get '/browse' => 'calendar#index'
  get '/about' => 'home#about'

  root :to => "home#index"
end
