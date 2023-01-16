FactoryBot.define do
  factory :notification, class: Notification do
    association :user, factory: :user
    association :actor, factory: :user
    notify_type { "follow" }
  end

  factory :read_notification, class: Notification do
    association :user, factory: :user
    association :actor, factory: :user
    notify_type { "follow" }
    is_opened { true }
    opened_at { Time.now }
  end
end
