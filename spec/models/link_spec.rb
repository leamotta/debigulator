require 'rails_helper'

describe Link do
  subject(:link) { build(:link) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:destination) }
  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_length_of(:code).is_at_most(7) }
end
