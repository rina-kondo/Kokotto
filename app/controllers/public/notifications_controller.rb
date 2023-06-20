class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).order(created_at: :desc)
    unread_notifications = current_user.unread_notifications
    unread_notifications.update_all(has_read: true)
  end

  def modal
    unread_notifications = current_user.unread_notifications.order(created_at: :desc)
    notification_data = unread_notifications.map do |notification|
      { date: l(notification.created_at, format: :long), action: helpers.notification_action_text(notification), post_id: notification.post_id }
    end
    unread_notifications.update_all(has_read: true)

    render json: notification_data
  end
end
