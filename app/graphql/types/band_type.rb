Types::BandType = GraphQL::ObjectType.define do
  name "Band"

  field :slug, !types.String
  field :name, !types.String
  field :performances, types[Types::PerformanceType] do
    argument :limit, types.Int
    resolve ->(obj, args, ctx) {
      limit = (args['limit'] && args['limit'] <= 25) ? args['limit'] : 10
      obj.performances.order(date: 'desc').limit(limit)
    }
  end
end
