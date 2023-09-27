# frozen_string_literal: true

describe Shortener do
  describe 'call' do
    subject { described_class.call(original) }

    let(:original) { Faker::Internet.url }

    context 'when generated string doest not match short field in database' do
      it 'calls SecureRandom and database once' do
        expect(SecureRandom).to receive(:alphanumeric).with(5).once.and_return('A1b2C')
        expect(Url).to receive(:find_by).once.and_return(nil)
        subject
      end
    end

    context 'when generated string already exists in database' do
      it 'calls SecureRandom and database twice' do
        url = create(:url, short: 'A1b2C')
        expect(SecureRandom).to receive(:alphanumeric).with(5).twice.and_return('A1b2C', 'B2cA1')
        expect(Url).to receive(:find_by).twice.and_return(url, nil)
        subject
      end
    end
  end
end
