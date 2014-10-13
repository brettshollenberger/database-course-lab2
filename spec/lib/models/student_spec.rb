require "spec_helper"

describe Models::Student do
  before(:all) do
    @connection = Connection.new(:host => "127.0.0.1",
                                 :username => "root",
                                 :password => "",
                                 :database => "personal")

    DbApplication.connection = @connection
  end

  it "finds data" do
    student = Models::Student.where(:last_name => "CAR")
    expect(student.first.first_name).to eq "MAUDE"
  end
end
