class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).recent
    unchecked_notifications = @notifications.where(has_read: false)
    unchecked_notifications.update_all(has_read: true)
  end
end
