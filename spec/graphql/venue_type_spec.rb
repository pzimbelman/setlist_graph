require 'rails_helper'

describe Types::VenueType do
  let(:venue_fields) { SetlistGraphSchema.types["Venue"].fields.keys }

  it 'should allow retrieval of permitted attributes' do
    expect(venue_fields).to_not include('id')
    expect(venue_fields).to include('name')
    expect(venue_fields).to include('city')
    expect(venue_fields).to include('state')
  end
end
