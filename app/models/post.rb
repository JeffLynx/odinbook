class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :body, presence: true, length: { maximum: 230 }
end
