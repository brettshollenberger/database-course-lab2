class ResultSet
  include Enumerable
  attr_accessor :results, :execution_time

  def initialize(results, execution_time)
    @results = results
    @execution_time = execution_time
  end

  def each(&block)
    @results.each(&block)
  end
end
