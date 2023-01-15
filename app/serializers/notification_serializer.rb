class NotificationSerializer < Plucker::Base
    cache
    attributes :id, :actor, :notify_type, :redirect_url, :is_opened, :created_at, :actor_count
    belongs_to :actor
    belongs_to :target
    belongs_to :second_target
    belongs_to :third_target
end
  