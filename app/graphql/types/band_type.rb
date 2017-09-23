Types::BandType = GraphQL::ObjectType.define do
  name "Band"

  field :slug, !types.String
  field :name, !types.String
end
