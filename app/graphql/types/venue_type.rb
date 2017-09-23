Types::VenueType = GraphQL::ObjectType.define do
  name "Venue"

  field :name, !types.String
  field :city, !types.String
  field :state, !types.String
end
