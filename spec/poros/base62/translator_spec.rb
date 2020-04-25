require 'rails_helper'

describe Base62::Translator do
  describe '#encode' do
    subject(:encode) do
      described_class.encode(number)
    end

    context 'when encoding a negative number' do
      let(:number) { Faker::Number.negative }

      it 'returns nil' do
        expect(encode).to eq(nil)
      end
    end

    context 'when encoding zero' do
      let(:number) { 0 }

      it 'returns "0"' do
        expect(encode).to eq('0')
      end
    end

    context 'when encoding 4242424242' do # checked online
      let(:number) { 4_242_424_242 }

      it 'returns 4d6mLS' do
        expect(encode).to eq('4D6Mls')
      end
    end
  end
end
