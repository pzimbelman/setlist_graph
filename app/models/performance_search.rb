class PerformanceSearch
  SearchError = Class.new(StandardError)
  def initialize(args = {})
    @args = args
    @offset = @args[:offset] || 0
  end

  def results
    band = find_band_criteria
    performances = Performance.scoped
    performances = performances.where(band_id: band.id) if band
    performances = performances.where(date: @args[:date]) if @args[:date]
    performances.order_by(date: "desc").offset(@offset).limit(10).entries
  end

  private
  def find_band_criteria
    return unless @args[:band]
    band = Band.where(slug: @args[:band]).first
    raise SearchError.new("Band could not be found") unless band
    band
  end
end
