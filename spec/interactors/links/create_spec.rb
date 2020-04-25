require 'rails_helper'

describe Links::Create do
  describe '#call' do
    subject(:create) do
      described_class.call(url: url)
    end

    let(:code) { Faker::Lorem.characters(number: 7) }
    let(:base62_poro) { class_double('Base62::Translator').as_stubbed_const }

    before do
      allow(base62_poro).to receive(:encode).and_return(code)
    end

    context 'when receiving a correct url' do
      let(:url) { Faker::Internet.url }

      it 'succeeds' do
        expect(create).to be_a_success
      end

      it 'creates a new link' do
        expect { create }.to(change(Link, :count).by(1))
      end

      it 'returns a new link' do
        expect(create.link).to be_an_instance_of(Link)
      end

      it 'calls the base62 encoder once' do
        create
        expect(base62_poro).to have_received(:encode).exactly(1).times
      end
    end

    context 'when not receiving a url' do
      let(:url) { nil }

      it 'fails' do
        expect(create).to be_a_failure
      end

      it 'does not create a new link' do
        expect { create }.not_to(change(Link, :count))
      end

      it 'returns the errors' do
        expect(create.errors).not_to be_empty
      end
    end
  end
end
