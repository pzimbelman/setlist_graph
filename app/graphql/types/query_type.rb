Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :band, types.String do
    type Types::BandType
    argument :slug, types.String
    resolve ->(obj, args, ctx) {
      Band.where(args.to_h.symbolize_keys).first
    }
  end

  field :venue, types.String do
    type Types::VenueType
  end

  field :performance, types.String do
    type Types::PerformanceType
    argument :date, types.String
    argument :band, types.String
    resolve ->(obj, args, ctx) {
      band = Band.where(slug: args['band']).first
      Performance.where(band_id: band.id, date: args['date']).first
    }
  end
end
