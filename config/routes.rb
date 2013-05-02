CapsCalendar::Application.routes.draw do
  match '/calendar/:id' => 'calendar#show'
  match '/calendar/:id/:event_id' => 'event#show'

  root :to => "home#index"
end
