class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :bookmarks
  validates :overview, presence: true
end
