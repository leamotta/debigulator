module Links
  class Create
    include Interactor
    MAX_NUMBER = 3.5216146e+12.to_i # Biggest number that could be converted into 7 base62 chars

    delegate :url, to: :context

    # Generates a link.
    # If there is a collision, we try again with a different random number.
    # Change this logic if the platform scales up.
    def call
      save_new_link

      return if link.persisted?

      save_new_link if link.already_taken?(:code)

      context.fail!(errors: link.errors.messages) unless link.persisted?
    end

    private

    def link
      context.link
    end

    def save_new_link
      context.link = Link.new(code: code, destination: url)
      link.save
    end

    def code
      Base62::Translator.encode(rand(MAX_NUMBER))
    end
  end
end
