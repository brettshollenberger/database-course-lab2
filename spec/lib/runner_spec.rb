require "spec_helper"

describe Runner do
  before(:all) do
    @connection = Connection.new(:host => "127.0.0.1",
                                 :username => "root",
                                 :password => "",
                                 :database => "personal")

    DbApplication.connection = @connection
  end

  it "finds students by last name" do
    students = Runner.students("LARKINS")
    expect(students.first.first_name).to eq "GAYLE"
  end

  it "finds students by teacher" do
    students = Runner.students_by_teacher("MACROSTIE")
    expect(students.length).to eq 3
  end

  it "finds students by classroom" do
    students = Runner.students_by_classroom(101)
    expect(students.length).to eq 3
  end
end
