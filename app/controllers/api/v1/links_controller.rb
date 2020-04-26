module Api
  module V1
    class LinksController < ApiController
      before_action :authenticate_request

      def create
        result = Links::Create.call(url: url)

        if result.success?
          render json: LinkSerializer.new(result.link).serialized_json, status: :created
        else
          unprocessable_entity(result.errors)
        end
      end

      private

      def url
        params.require(:url)
      end
    end
  end
end
