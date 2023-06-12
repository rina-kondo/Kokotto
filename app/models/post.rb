class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :user_id, presence: true
  validates :text, presence: true, length: {maximum:50}
  validates :latitude, presence: true
  validates :longitude, presence: true

  def display_image(width,height)
    image.attached? ? image.variant(resize_to_limit: [width, height]).processed : "";
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
