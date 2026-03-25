class Entry < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :username, presence: true
  validates :password, presence: true
  validate :url_must_be_valid

  private

  def url_must_be_valid
    url_is_valid = errors.add(:url, "must be valid") unless url.match? URI::DEFAULT_PARSER.make_regexp
    unless url_is_valid
      errors.add(:url, "must be valid")
    end
  end
end
