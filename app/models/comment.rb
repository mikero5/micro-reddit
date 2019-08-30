class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :User, optional: true
  belongs_to :Post, optional: true
end
