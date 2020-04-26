require 'rails_helper'

describe Api::V1::LinksController do
  describe 'POST #create' do
    subject(:http_request) { post :create, params: { url: url } }

    context 'when creating a link with correct params' do
      let(:url) { Faker::Internet.url }

      let(:interactor_stub) { class_double('Links::Create').as_stubbed_const }
      let(:interactor_response) { double }
      let(:link) { create(:link) }
      let(:serializer_stub_class) { class_double('LinkSerializer').as_stubbed_const }
      let(:serializer_stub_object) { double }

      before do
        allow(interactor_stub).to receive(:call).and_return(interactor_response)
        allow(interactor_response).to receive(:success?).and_return(true)
        allow(interactor_response).to receive(:link).and_return(link)
        allow(serializer_stub_class).to receive(:new).and_return(serializer_stub_object)
        allow(serializer_stub_object).to receive(:serialized_json).and_return({})
      end

      it 'calls the create interactor' do
        http_request
        expect(interactor_stub).to have_received(:call).exactly(1).times
      end

      it 'calls the model serializer' do
        http_request
        expect(serializer_stub_class).to have_received(:new).exactly(1).times
        expect(serializer_stub_object).to have_received(:serialized_json).exactly(1).times
      end

      it 'responds with status 201, created' do
        expect(http_request).to have_http_status(:created)
      end
    end

    context 'when creating a link with correct params but interactor fails' do
      let(:url) { Faker::Internet.url }

      let(:interactor_stub) { class_double('Links::Create').as_stubbed_const }
      let(:interactor_response) { double }

      before do
        allow(interactor_stub).to receive(:call).and_return(interactor_response)
        allow(interactor_response).to receive(:success?).and_return(false)
        allow(interactor_response).to receive(:errors).and_return('code taken')
      end

      it 'calls the create interactor' do
        http_request
        expect(interactor_stub).to have_received(:call).exactly(1).times
      end

      it 'responds with status 422, unprocessable entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when creating a link with missing parameters' do
      let(:url) { nil }

      include_examples 'parameter missing'
    end
  end
end
