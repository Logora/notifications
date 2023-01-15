Notifications::Engine.routes.draw do
  root to: "notifications#index", as: :notifications_index
  post '/read/all', to: "notifications#read_all", as: :notifications_read_all
  post '/read/:id', to: "notifications#read", as: :notification_read
end
