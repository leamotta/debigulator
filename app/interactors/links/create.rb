module Links
  class Create
    include Interactor

    delegate :url, :code_generator, :link, to: :context

    before do
      context.code_generator ||= Base62::Generator
    end

    after do
      cache_link
    end

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

    def save_new_link
      context.link = Link.new(code: code, destination: url)
      link.save
    end

    def code
      code_generator.random_string(7)
    end

    def cache_link
      Cache.write(link.code, url, 60.seconds)
    end
  end
end
