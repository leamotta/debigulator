class Cache
  def self.read(key)
    Rails.cache.read(key)
  end

  def self.write(key, value, expires_in = Rails.application.secrets.redis[:expiration])
    Rails.cache.write(key, value, expires_in: expires_in)
  end

  def self.delete(key)
    Rails.cache.delete(key)
  end

  def self.clear
    Rails.cache.clear
  end
end
