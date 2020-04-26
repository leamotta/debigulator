require 'rails_helper'

describe Partner do
  subject(:partner) { build(:partner) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:token) }
end
