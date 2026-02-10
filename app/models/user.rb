class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  after_create :create_profile

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :sent_follows,
    class_name: "Follow",
    foreign_key: :follower_id,
    dependent: :destroy

  has_many :received_follows,
    class_name: "Follow",
    foreign_key: :followed_id,
    dependent: :destroy

  has_many :following,
    -> { where(follows: { status: :accepted }) },
    through: :sent_follows,
    source: :followed

  has_many :followers,
    -> { where(follows: { status: :accepted }) },
    through: :received_follows,
    source: :follower
end
