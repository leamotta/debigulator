class LandingController < ApplicationController
  def index
    @view_data['code'] = params[:code]
    @view_data['errors'] = params[:errors]

    render action: :index
  end
end
