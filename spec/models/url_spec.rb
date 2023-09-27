# frozen_string_literal: true

describe Url do
  describe 'validations' do
    subject { build(:url) }

    it { is_expected.to validate_presence_of(:original) }
    it { is_expected.to validate_url_of(:original) }
    it { is_expected.to validate_presence_of(:short) }
    it { is_expected.to validate_uniqueness_of(:short) }
  end
end
