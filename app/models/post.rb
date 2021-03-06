class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  belongs_to :User, foreign_key: "user_id"  #, optional: true  # using optional true here, but shouldn't be needed
  has_many :Comments
end
