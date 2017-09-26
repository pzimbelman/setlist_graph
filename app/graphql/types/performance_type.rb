Types::PerformanceType = GraphQL::ObjectType.define do
  name "Performance"

  field :date, !types.String
  field :first_set, types[types.String]
  field :second_set, types[types.String]
  field :third_set, types[types.String]
  field :fourth_set, types[types.String]
  field :encore, types[types.String]
  field :double_encore, types[types.String]
end
