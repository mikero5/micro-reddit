class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :User, foreign_key: "user_id" #, optional: true
  belongs_to :Post, foreign_key: "post_id" #, optional: true
end
