class Band
  include Mongoid::Document

  field :_id, as: :id, type: String, default: -> { SecureRandom.uuid }
  field :name, type: String
  field :slug, type: String
  has_many :performances
end
