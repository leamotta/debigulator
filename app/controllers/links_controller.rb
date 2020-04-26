class LinksController < ApplicationController
  def create
    result = ::Links::Create.call(url: url)
    redirect_params = if result.success?
                        { code: result.link.code }
                      else
                        { errors: result.errors }
                      end

    redirect_to controller: 'landing', action: 'index', params: redirect_params
  end

  def redirect
    result = ::Links::Redirect.call(code: params[:code])

    if result.success?
      redirect_to result.destination
    else
      not_found
    end
  end

  private

  def url
    params.require(:url)
  end
end
