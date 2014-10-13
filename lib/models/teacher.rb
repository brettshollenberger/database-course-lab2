module Models
  class Teacher < Base
    attr_accessor :id, :first_name, :last_name, :classroom

    def self.table_name
      "teachers"
    end

    def self.columns
      [:id, :first_name, :last_name, :classroom]
    end
  end
end
