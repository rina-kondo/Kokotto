class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # varidates :text, presence: true
end
