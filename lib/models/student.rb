module Models
  class Student < Base
    attr_accessor :id, :first_name, :last_name, :grade, :classroom

    def self.table_name
      "students"
    end

    def self.columns
      [:id, :first_name, :last_name, :grade, :classroom]
    end
  end
end
