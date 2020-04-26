require 'rails_helper'

shared_examples 'unauthorized' do
  before do
    http_request
  end

  it 'responds with unauthorized and sets an error' do
    expect(response).to have_http_status(:unauthorized)
    expect(response_body['errors']).not_to be_nil
  end
end
