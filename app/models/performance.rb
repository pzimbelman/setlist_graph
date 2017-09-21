class Performance
  include Mongoid::Document

  field :_id, as: :id, type: String, default: -> { SecureRandom.uuid }
  field :band_id, type: String
  field :venue_id, type: String
  field :date, type: Date
  field :first_set, type: Array
  field :second_set, type: Array
  field :third_set, type: Array
  field :fourth_set, type: Array
  field :encore, type: Array
  field :double_encore, type: Array
  belongs_to :band
  belongs_to :venue

  validates :band_id, :venue_id, :date, presence: true
end
