class Entry < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :username, presence: true
  validates :password, presence: true
end
