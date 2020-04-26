class Partner < ApplicationRecord
  validates :name, :token, presence: true
end
