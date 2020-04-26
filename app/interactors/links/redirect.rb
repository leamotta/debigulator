module Links
  class Redirect
    include Interactor

    delegate :code, to: :context

    def call
      context.destination = Cache.read(code) || Link.find_by(code: code)&.destination
      context.fail!(errors: 'Not found') unless context.destination
    end
  end
end
