class LinkSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination

  attribute :short_link do |object|
    "#{Rails.application.secrets[:base_url]}#{object.code}"
  end
end
