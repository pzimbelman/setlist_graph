require 'rails_helper'

describe Types::BandType do
  let(:band_fields) { SetlistGraphSchema.types["Band"].fields.keys }

  it 'should allow retrieval of permitted attributes' do
    expect(band_fields).to_not include('id')
    expect(band_fields).to include('name')
    expect(band_fields).to include('slug')
  end
end
