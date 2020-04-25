class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :initialize_view_data

  def initialize_view_data
    @view_data = {}
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
