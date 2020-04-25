module Links
  class Create
    include Interactor
    MAX_NUMBER = 3.5216146e+12.to_i # Biggest number that could be converted into 7 base62 chars

    delegate :url, to: :context

    def call
      context.link = Link.new(code: code, destination: url)

      context.fail!(errors: link.errors.messages) unless link.save
    end

    private

    def link
      context.link
    end

    def code
      @code ||= Base62::Translator.encode(rand(MAX_NUMBER))
    end
  end
end
