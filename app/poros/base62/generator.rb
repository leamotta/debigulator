module Base62
  class Generator
    def self.random_string(length)
      Base62::Translator.encode(rand(62**length))
    end
  end
end
