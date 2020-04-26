require 'rails_helper'

describe Links::Create do
  describe '#call' do
    subject(:creation) do
      described_class.call(url: url)
    end

    let(:code) { Faker::Lorem.characters(number: 7) }
    let(:base62_poro) { class_double('Base62::Translator').as_stubbed_const }

    before do
      allow(base62_poro).to receive(:encode).and_return(code)
      allow(Cache).to receive(:write).and_return('OK')
    end

    context 'when receiving a correct url' do
      let(:url) { Faker::Internet.url }

      it 'succeeds' do
        expect(creation).to be_a_success
      end

      it 'creations a new link' do
        expect { creation }.to(change(Link, :count).by(1))
      end

      it 'returns a new link' do
        expect(creation.link).to be_an_instance_of(Link)
      end

      it 'calls the base62 encoder once' do
        creation
        expect(base62_poro).to have_received(:encode).exactly(1).times
      end

      it 'calls a write on cache' do
        creation
        expect(Cache).to have_received(:write).with(
          creation.link.code, creation.link.destination, 60.seconds
        )
      end
    end

    context 'when code collisions' do
      let(:url) { Faker::Internet.url }
      let!(:link) { create(:link, code: code) }

      before do
        allow(base62_poro).to receive(:encode).and_return(code, code[0...-1])
      end

      it 'succeeds' do
        expect(creation).to be_a_success
      end

      it 'creations a new link' do
        expect { creation }.to(change(Link, :count).by(1))
      end

      it 'returns a new link' do
        expect(creation.link).to be_an_instance_of(Link)
      end

      it 'calls the base62 encoder twice' do
        creation
        expect(base62_poro).to have_received(:encode).exactly(2).times
      end
    end

    context 'when not receiving a url' do
      let(:url) { nil }

      it 'fails' do
        expect(creation).to be_a_failure
      end

      it 'does not creation a new link' do
        expect { creation }.not_to(change(Link, :count))
      end

      it 'returns the errors' do
        expect(creation.errors).not_to be_empty
      end
    end
  end
end
