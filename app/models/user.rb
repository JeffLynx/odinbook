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

  # All sent follows (for managing all follow states)
  has_many :all_sent_follows,
    class_name: "Follow",
    foreign_key: :follower_id,
    dependent: :destroy

  # Only accepted sent follows
  has_many :sent_follows,
    -> { where(status: :accepted) },
    class_name: "Follow",
    foreign_key: :follower_id,
    dependent: :destroy

  # All received follows (for managing requests and accepted)
  has_many :all_received_follows,
    class_name: "Follow",
    foreign_key: :followed_id,
    dependent: :destroy

  # Only accepted received follows
  has_many :received_follows,
    -> { where(status: :accepted) },
    class_name: "Follow",
    foreign_key: :followed_id,
    dependent: :destroy

  has_many :following,
    through: :sent_follows,
    source: :followed

  has_many :followers,
    through: :received_follows,
    source: :follower

  def follow(user)
    all_sent_follows.create(followed: user, status: :pending)
  end

  def unfollow(user)
    all_sent_follows.find_by(followed: user)&.destroy
  end

  def following?(user)
    sent_follows.exists?(followed: user)
  end

  def requested_follow?(user)
    all_sent_follows.exists?(followed: user, status: :pending)
  end

  def received_follow_requests
    all_received_follows.where(status: :pending).includes(:follower)
  end
end

