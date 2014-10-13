module Models
  class Where < Hash
    def initialize(options)
      options.each do |k, v|
        self[k] = v
      end
    end

    def to_clause
      return "" if keys.empty?

      clause = "WHERE "

      each do |key, value|
        clause += "#{key}='#{value}' AND "
      end

      clause = clause[0..-6]
    end
  end
end
