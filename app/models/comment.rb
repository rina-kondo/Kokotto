class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :text, presence: true, length: {maximum: 100}

  def create_notification_comment!(current_user, comment_user_id)
    notification = current_user.active_notifications.new(
      post_id: post_id,
      visited_id: comment_user_id,
      comment_id: id,
      action: 'comment',
      has_read: current_user.id == comment_user_id
    )
    notification.save if notification.valid?
  end
end
