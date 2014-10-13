class DbApplication
  def self.connection
    @connection
  end

  def self.connection=(connection)
    @connection = connection
  end
end
