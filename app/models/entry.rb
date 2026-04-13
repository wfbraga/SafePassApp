class Entry < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :username, presence: true
  validates :password, presence: true
  validate :url_must_be_valid

  encrypts :username, deterministic: true
  encrypts :password

  scope :search_name, -> (name) {
    where("name ILIKE ?", "%#{name}%") if name.present?
  }
  def self.search(name)
    search_name(name).order(:name)
  end

  private

  def url_must_be_valid
    errors.add(:url, "must be valid") unless url.match? URI::DEFAULT_PARSER.make_regexp
  end
end
