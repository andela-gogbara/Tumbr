class User < ActiveRecord::Base
  has_many :subscriptions, foreign_key: :follower_id, dependent: :destroy

  has_many :leaders, through: :subscriptions

  has_many :reverse_subscriptions, foreign_key: :leader_id, dependent: :destroy, class_name: "Subscription"

  has_many :followers, through: :reverse_subscriptions
  def following?(leader)
    leaders.include? leader
  end

  def follow!(leader)
    if leader != self && !following?(leader)
      leaders << leader
    end
  end
end
