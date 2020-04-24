class Link < ApplicationRecord
  validates :code, :destination, presence: true
  validates :code, length: { maximum: 7 }, uniqueness: true
end
