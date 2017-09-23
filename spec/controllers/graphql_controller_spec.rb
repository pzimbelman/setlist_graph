require 'rails_helper'

describe GraphqlController do
  let!(:band) { Band.create!(name: 'Phish', slug: 'phish') }

  it 'will return the bands name and slug when requested' do
    post :execute, params: { query: "{ band(slug: \"phish\") { name slug } }" }
    json_response = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json_response['data']['band']['name']).to eq('Phish')
  end
end
