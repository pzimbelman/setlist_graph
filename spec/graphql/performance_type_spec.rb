require 'rails_helper'

describe Types::PerformanceType do
  let(:performance_fields) { SetlistGraphSchema.types["Performance"].fields.keys }

  it 'should allow retrieval of permitted attributes' do
    expect(performance_fields).to_not include('id')
    expect(performance_fields).to include('date')
    expect(performance_fields).to include('first_set')
    expect(performance_fields).to include('second_set')
    expect(performance_fields).to include('third_set')
    expect(performance_fields).to include('fourth_set')
    expect(performance_fields).to include('encore')
    expect(performance_fields).to include('double_encore')
    expect(performance_fields).to include('venue')
  end
end
