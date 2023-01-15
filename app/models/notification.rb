module Notifications
  class Notification < ApplicationRecord
    include Wisper::Publisher
  
    after_commit :publish_create_event, :on => :create
    after_commit :publish_save_event, :on => :update
    
    scope :unread, -> { where(is_opened: false).order(created_at: :desc) }
  
    belongs_to :actor, class_name: Notifications.config.user_class, optional: true
    belongs_to :user, class_name: Notifications.config.user_class, touch: true
    belongs_to :target, polymorphic: true, optional: true
    belongs_to :second_target, polymorphic: true, optional: true
    belongs_to :third_target, polymorphic: true, optional: true
  
    validates_presence_of :user
    validates_presence_of :notify_type

    def read
      unless self.is_opened
        self.is_opened = true
        self.opened_at = Time.now
        self.save
      end
    end
  
    def unread
      if self.is_opened
        self.is_opened = false
        self.opened_at = nil
        self.save
      end
    end

    private
    def publish_create_event
      event_name = "notification_created".to_sym
      broadcast(event_name, self.id)
    end
  
    def publish_save_event
      event_name = "notification_saved".to_sym
      broadcast(event_name, self.id)
    end
  end  
end
