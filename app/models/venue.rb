class Venue
  include Mongoid::Document

  field :_id, as: :id, type: String, default: -> { SecureRandom.uuid }
  field :name,  type: String
  field :city,  type: String
  field :state, type: String
end
