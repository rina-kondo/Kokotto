class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }

  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@kokotto.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def unread_notifications
    passive_notifications.where.not(visitor_id: id).where(has_read: false)
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

end
