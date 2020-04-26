require 'rails_helper'

shared_examples 'parameter missing' do
  before do
    http_request
  end

  it 'responds with bad request and specifies an error' do
    expect(response).to have_http_status(:bad_request)
    expect(response_body['errors']).not_to be_nil
  end
end
