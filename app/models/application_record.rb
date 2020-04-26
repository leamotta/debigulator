class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def already_taken?(field)
    errors.details[field].any? { |detail| detail[:error] == :taken }
  end
end
