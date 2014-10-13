require "mysql"
require "forwardable"

class Connection
  extend Forwardable

  attr_accessor :connection

  def initialize(options={})
    @connection = Mysql.new(options[:host],
                            options[:username],
                            options[:password],
                            options[:database])
  end

  def prepare(statement="")
    Statement.new @connection.prepare(statement)
  end
end
