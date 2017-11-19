require 'rails_helper'

describe GraphqlController do
  let!(:band) { Band.create!(name: 'Phish', slug: 'phish') }
  let(:venue) { Venue.create!(city: 'New York', state: 'NY', name: 'MSG') }
  let!(:performance) do
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

  it 'will allow retrieval of a bands most recent performances' do
    post :execute, params: { query: "{ band(slug: \"phish\") { performances { first_set }} }" }
    json_response = JSON.parse(response.body)
    expect(response.status).to eq(200)
    performances = json_response['data']['band']['performances']
    expect(performances.count).to eq(1)
    expect(performances.first['first_set']).to eq(['The Lizards'])
  end

  it 'will allow specifying a limit on the performances' do
    Performance.create!(date: Date.parse('2017-12-21'),
      band: band, venue: venue, first_set: ['The Lizards'])
    post :execute, params: { query: "{ band(slug: \"phish\") { performances(limit: 1) { date }}}" }
    json_response = JSON.parse(response.body)
    expect(json_response['data']['band']['performances'].count).to eq(1)
  end

  it 'will allow looking up a performance by band and date' do
    post :execute, params: { query: "{ performance(band: \"phish\", date: \"#{performance.date}\") { date first_set } }" }
    json_response = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json_response['data']['performance']['date']).to eq('2017-12-20')
    expect(json_response['data']['performance']['first_set']).to eq(['The Lizards'])
  end

  it 'will handle not finding the requested band' do
    post :execute, params: { query: "{ performance(band: \"fakeband\", date: \"#{performance.date}\") { date first_set } }" }
    json_response = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json_response['errors'].first['message']).to eq('Band could not be found')
  end

  it 'will allow retrieving a list of performances' do
    Performance.create!(date: Date.parse('2017-12-20'),
      band: band, venue: venue, first_set: ['The Lizards'])
    post :execute, params: { query: "{ performances { date first_set } }" }

    json_response = JSON.parse(response.body)
    expect(json_response['data']['performances'].count).to eq(2)
    expect(json_response['data']['performances'].first['date']).to eq('2017-12-20')
  end

  it 'will allow retrieving a list of performances for a particular band' do
    Performance.create!(date: Date.parse('2019-12-20'),
      band: Band.create!(name: "foo", slug: "foo"), venue: venue, first_set: ['The Lizards'])
    post :execute, params: { query: "{ performances(band: \"phish\") { date first_set } }" }

    json_response = JSON.parse(response.body)
    expect(json_response['data']['performances'].count).to eq(1)
    expect(json_response['data']['performances'].first['date']).to eq('2017-12-20')
  end

  it 'will allow specifying an offset so that clients can page through results' do
    Performance.create!(date: Date.parse('2019-12-20'),
      band: band, venue: venue, first_set: ['The Lizards'])
    post :execute, params: { query: "{ performances(offset: 1) { date first_set } }" }

    json_response = JSON.parse(response.body)
    expect(json_response['data']['performances'].count).to eq(1)
    expect(json_response['data']['performances'].first['date']).to eq('2017-12-20')
  end
end
