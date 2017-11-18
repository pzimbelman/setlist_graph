Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :band, types.String do
    type Types::BandType
    argument :slug, !types.String
    resolve ->(obj, args, ctx) {
      Band.where(args.to_h.symbolize_keys).first
    }
  end

  field :performance, types.String do
    type Types::PerformanceType
    argument :date, types.String
    argument :band, !types.String
    resolve ->(obj, args, ctx) {
      begin
        search = PerformanceSearch.new(band: args['band'], date: args['date'])
        search.results.first
      rescue PerformanceSearch::SearchError => e
        GraphQL::ExecutionError.new(e.message)
      end
    }
  end
end
