module Base62
  class Translator
    KEYS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze
    BASE = KEYS.length

    def self.encode(number)
      return '0' if number.zero?
      return nil if number.negative?

      result = ''
      while number.positive?
        result = KEYS[number % BASE] + result
        number /= BASE
      end
      result
    end
  end
end
