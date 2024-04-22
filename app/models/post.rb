class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  belongs_to :tag

  before_save :sanitize_content

  validates :title, presence: true
  validates :subtitle, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  paginates_per 3

  private

  def sanitize_content
    self.body = Loofah.scrub_fragment(body, :prune).to_s
  end
end
