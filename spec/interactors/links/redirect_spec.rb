require 'rails_helper'

describe Links::Redirect do
  describe '#call' do
    subject(:redirect) do
      described_class.call(code: code)
    end

    let(:code) { Faker::Lorem.characters(number: 7) }
    let(:destination) { Faker::Internet.url }

    context 'when there is a hit on cache' do
      before do
        allow(Cache).to receive(:read).and_return(destination)
        allow(Link).to receive(:find_by).and_return(nil)
      end

      it 'succeeds' do
        expect(redirect).to be_a_success
      end

      it 'saves the link to the context' do
        expect(redirect.destination).to eq(destination)
      end

      it 'calls a read on cache' do
        redirect
        expect(Cache).to have_received(:read).with(code)
        expect(Cache.read(code)).to eq(destination)
      end

      it 'does not call a find to the Link model' do
        redirect
        expect(Link).to have_received(:find_by).exactly(0).times
      end
    end

    context 'when there is no hit on cache but there is a database record' do
      let!(:link) { create(:link, code: code) }

      before do
        allow(Cache).to receive(:read).and_return(nil)
      end

      it 'succeeds' do
        expect(redirect).to be_a_success
      end

      it 'saves the link to the context' do
        expect(redirect.destination).to eq(link.destination)
      end

      it 'calls a missed read on cache' do
        redirect
        expect(Cache).to have_received(:read).with(code)
        expect(Cache.read(code)).to eq(nil)
      end
    end

    context 'when there is no hit on cache and there is no database record' do
      let(:code) { '42' }

      before do
        allow(Cache).to receive(:read).and_return(nil)
      end

      it 'fails' do
        expect(redirect).to be_a_failure
      end
    end
  end
end
