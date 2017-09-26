require 'rails_helper'

describe GraphqlController do
  let!(:band) { Band.create!(name: 'Phish', slug: 'phish') }
  let(:venue) { Venue.create!(city: 'New York', state: 'NY', name: 'MSG') }
  let(:performance) do
    Performance.create!(date: Date.parse('2017-12-20'),
      band: band,
      venue: venue,
      first_set: ['The Lizards']
    )
  end

  it 'will return the bands name and slug when requested' do
    post :execute, params: { query: "{ band(slug: \"phish\") { name slug } }" }
    json_response = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json_response['data']['band']['name']).to eq('Phish')
  end

  it 'will allow looking up a performance by band and date' do
    post :execute, params: { query: "{ performance(band: \"phish\", date: \"#{performance.date}\") { date first_set } }" }
    json_response = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json_response['data']['performance']['date']).to eq('2017-12-20')
    expect(json_response['data']['performance']['first_set']).to eq(['The Lizards'])
  end
end
