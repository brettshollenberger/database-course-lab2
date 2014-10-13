class Statement
  attr_accessor :statement

  def initialize(statement="")
    @statement = statement
  end

  def execute
    start_time = Time.now
    result = @statement.execute
    execution_time = Time.now - start_time
    ResultSet.new result, execution_time
  end
end

