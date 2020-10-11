class Friendship < ApplicationRecord
  belongs_to :user

  validates :user_id, :friend_id, presence: true
  validates_uniqueness_of :friend_id, scope: :user_id
end
