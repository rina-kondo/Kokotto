class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  validates :name, length: { minimum: 2, maximum: 20 }

  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@kokotto.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def activities
    query = <<-SQL
      (SELECT 'Post' as record_type, id, created_at FROM posts WHERE user_id = :user_id)
      UNION ALL
      (SELECT 'Comment' as record_type, id, created_at FROM comments WHERE user_id = :user_id)
      ORDER BY created_at DESC
    SQL

    ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.send(:sanitize_sql_array, [query, user_id: id])
    )
  end

end
