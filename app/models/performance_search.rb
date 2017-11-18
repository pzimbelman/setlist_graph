class PerformanceSearch
  SearchError = Class.new(StandardError)
  def initialize(args = {})
    @args = args
  end

  def results
    band = find_band_criteria
    performances = Performance.scoped
    performances = performances.where(band_id: band.id) if band
    performances = performances.where(date: @args[:date]) if @args[:date]
    performances.order_by(date: "desc").limit(10).entries
  end

  private
  def find_band_criteria
    return unless @args[:band_id]
    band = Band.where(id: @args[:band_id]).first
    raise SearchError.new("Invalid band ID specified") unless band
    band
  end
end
