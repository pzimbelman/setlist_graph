require 'rails_helper'

describe PerformanceSearch do
  let(:band) { Band.create!(name: 'Phish', slug: 'phish') }
  let(:venue) { Venue.create!(city: 'New York', state: 'NY', name: 'MSG') }

  it 'will find the most recent performances for any band' do
    performance = Performance.create!(date: Date.parse('2017-12-20'),
      band: band, venue: venue, first_set: ['The Lizards'])
    search = PerformanceSearch.new

    expect(search.results.first).to eq(performance)
  end 

  it 'will order the results with the most recent performance first' do
    older_performance = Performance.create!(date: Date.parse('2016-12-20'),
      band: band, venue: venue, first_set: ['The Lizards'])
    newer_performance = Performance.create!(date: Date.parse('2017-12-20'),
      band: band, venue: venue, first_set: ['The Lizards'])
    search = PerformanceSearch.new

    expect(search.results.count).to eq(2)
    expect(search.results.first).to eq(newer_performance)
  end 


  it 'will allow specifying the band to search for' do
    other_band = Band.create!(name: 'OtherBand', slug: 'other')
    Performance.create!(date: Date.parse('2016-12-20'),
      band: other_band, venue: venue, first_set: ['The Lizards'])
    performance = Performance.create!(date: Date.parse('2017-12-20'),
      band: band, venue: venue, first_set: ['The Lizards'])
    search = PerformanceSearch.new(band_id: band.id)

    expect(search.results.count).to eq(1)
    expect(search.results.first).to eq(performance)
  end

  it 'will raise a search error if the band ID is invalid' do
    expect {
      PerformanceSearch.new(band_id: "aninvalidID").results
    }.to raise_error(PerformanceSearch::SearchError)
  end

  it 'will accept a particular date to search for' do
    Performance.create!(date: Date.parse('2017-12-20'),
      band: band, venue: venue, first_set: ['The Lizards'])
    performance = Performance.create!(date: Date.parse('2016-12-20'),
      band: band, venue: venue, first_set: ['The Lizards'])
    search = PerformanceSearch.new(date: '2016-12-20')

    expect(search.results.count).to eq(1)
    expect(search.results.first).to eq(performance)
  end 
end
