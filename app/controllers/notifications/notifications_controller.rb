module Notifications
  class NotificationsController < ApplicationController
    # GET /notifications
    def index
      notifications = Notification.includes(:actor, :target, :second_target).where(user_id: current_user.id, is_grouped: false, is_desktop: true)
      @pagy, notifications_paginated = pagy(notifications)
      render json: { success: true, data: Plucker::Collection.new(notifications_paginated, serializer: NotificationSerializer) }
    end

    # POST /notifications/read/:id
    def read
      @notification = Notification.find_by!(id: params[:id], user_id: current_user.id)
      if @notification.read
        render json: { success: true, data: { resource: NotificationSerializer.new(@notification) }}
      else
        raise Errors::UnprocessableEntityError.new(errors: @notification.errors.to_hash)
      end
    end

    # POST /notifications/read/all
    def read_all
      Notification.where(is_opened: false, user_id: current_user.id).in_batches(of: 1000).update_all(is_opened: true, opened_at: Time.now, updated_at: Time.now)
      render json: { success: true, data: {}}
    end
  end
end