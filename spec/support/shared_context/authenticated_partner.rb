shared_context 'with authenticated partner' do
  let(:partner) { create(:partner) }

  before do
    request.headers['Auth-Key'] = partner.token
  end
end
