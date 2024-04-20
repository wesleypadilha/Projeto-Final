class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true
  scope :sorted, ->{order(created_at: :desc)}
  validates :content, presence: true, length: { minimum: 10, maximum: 150 }
end
