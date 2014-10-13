module Models
  class Base
    attr_accessor :last_execution_time

    def initialize(attrs_array=[])
      self.class.columns.each do |column_name|
        self.send("#{column_name}=", attrs_array.shift)
      end
    end

    def self.connection
      DbApplication.connection
    end

    def self.execute_command(command)
      result = connection.prepare(command).execute
      @last_execution_time = result.execution_time
      result
    end

    def self.find(primary_key)
      execute_command(find_statement(primary_key)).map do |record|
        new record
      end.first
    end

    def self.all
      execute_command(all_statement).map do |record|
        new record
      end
    end

    def self.where(options={})
      execute_command(where_statement(options)).map do |record|
        new record
      end
    end

  private
    def self.all_statement
      "select * from #{table_name}"
    end

    def self.find_statement(primary_key)
      "#{all_statement} WHERE id=#{primary_key}"
    end

    def self.where_statement(options={})
      "#{all_statement} #{where_clause(options)}"
    end

    def self.where_clause(options={})
      Where.new(options).to_clause
    end
  end
end
