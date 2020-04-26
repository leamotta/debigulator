require 'rails_helper'

describe Cache do
  subject(:service) { described_class }

  let(:key) { Faker::Lorem.word }
  let(:value) { { data: Faker::Lorem.words(3) } }

  describe '#read' do
    it 'calls rails cache read' do
      allow(Rails.cache).to receive(:read).and_return(value)
      expect(service.read(key)).to eq(value)
      expect(Rails.cache).to have_received(:read).with(key)
    end
  end

  describe '#write' do
    let(:expires_in) { Rails.application.secrets.redis[:expiration] }

    it 'calls rails cache write' do
      allow(Rails.cache).to receive(:write).and_return('OK')
      expect(service.write(key, value)).to eq('OK')
      expect(Rails.cache).to have_received(:write).with(key, value, expires_in: expires_in)
    end
  end

  describe '#delete' do
    it 'calls rails cache delete' do
      allow(Rails.cache).to receive(:delete).and_return(1)
      expect(service.delete(key)).to eq(1)
      expect(Rails.cache).to have_received(:delete).with(key)
    end
  end

  describe '#clear' do
    it 'calls rails cache clear' do
      allow(Rails.cache).to receive(:clear)
      service.clear
      expect(Rails.cache).to have_received(:clear).with(no_args)
    end
  end
end
