class Post < ApplicationRecord
  validates :title, presence: true
  # scope 将数据库的查询方式封装成一个可复用的方法
  scope :recent, -> { order("created_at DESC") }

  belongs_to :user
  belongs_to :group
end
