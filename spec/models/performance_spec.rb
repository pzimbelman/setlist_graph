require 'rails_helper'

describe Performance do
  it { should validate_presence_of(:band_id) }
  it { should validate_presence_of(:venue_id) }
  it { should validate_presence_of(:date) }
end
