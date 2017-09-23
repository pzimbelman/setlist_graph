Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :band, types.String do
    type Types::BandType
    description "Details for a Band"
    argument :slug, types.String
    resolve ->(obj, args, ctx) {
      Band.where(args.to_h.symbolize_keys).first
    }
  end

  field :venue, types.String do
    type Types::VenueType
  end
end
