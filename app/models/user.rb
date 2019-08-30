class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  has_many :Posts
  has_many :Comments
end
