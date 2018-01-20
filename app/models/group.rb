class Group < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_many :group_relationships
  has_many :members, through: :users, source: :user
  validates :title, presence: true

end
