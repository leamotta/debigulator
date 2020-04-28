require 'rails_helper'

describe Links::Create do
  describe '#call' do
    subject(:creation) do
      described_class.call(url: url, code_generator: code_generator)
    end

    let(:code) { Faker::Lorem.characters(number: 7) }
    let(:code_generator) { class_double(generator_class).as_stubbed_const }
    let(:generator_class) { Faker::Name.first_name }

    before do
      allow(code_generator).to receive(:random_string).and_return(code)
      allow(Cache).to receive(:write).and_return('OK')
    end

    context 'when receiving a correct url' do
      let(:url) { Faker::Internet.url }

      it 'succeeds' do
        expect(creation).to be_a_success
      end

      it 'creates a new link' do
        expect { creation }.to(change(Link, :count).by(1))
      end

      it 'returns a new link' do
        expect(creation.link).to be_an_instance_of(Link)
      end

      it 'calls the code generator once' do
        creation
        expect(code_generator).to have_received(:random_string).exactly(1).times
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
        allow(code_generator).to receive(:random_string).and_return(code, code[0...-1])
      end

      it 'succeeds' do
        expect(creation).to be_a_success
      end

      it 'creates a new link' do
        expect { creation }.to(change(Link, :count).by(1))
      end

      it 'returns a new link' do
        expect(creation.link).to be_an_instance_of(Link)
      end

      it 'calls the code generator twice' do
        creation
        expect(code_generator).to have_received(:random_string).exactly(2).times
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
