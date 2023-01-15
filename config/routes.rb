Notifications::Engine.routes.draw do
  get 'notifications', to: "notifications#index", as: :user_notifications
  post 'notifications/read/all', to: "notifications#read_all", as: :notifications_read_all
  post 'notifications/read/:id', to: "notifications#read", as: :notification_read
end
