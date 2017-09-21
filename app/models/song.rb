class Song
  include Mongoid::Document

  field :_id, as: :id, type: String, default: -> { SecureRandom.uuid }
  field :name, type: String
end
