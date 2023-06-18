class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :text, presence: true, length: {maximum:100}
  validates :latitude, presence: true
  validates :longitude, presence: true

  def display_image(width,height)
    image.attached? ? image.variant(resize_to_limit: [width, height]).processed : "";
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end


  def create_notification_like!(current_user)
    like_record = Notification.where(
      "visitor_id = :visitor_id and visited_id = :visited_id and post_id = :post_id and action = :action",
      visitor_id: current_user.id,
      visited_id: user_id,
      post_id: id,
      action: 'like'
    )
    return if like_record.exists?

    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: 'like',
      has_read: current_user.id == user_id
    )
    notification.save if notification.valid?
  end

end
