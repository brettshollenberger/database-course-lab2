require "spec_helper"

describe Models::Base do
  before(:all) do
    @connection = Connection.new(:host => "127.0.0.1",
                                 :username => "root",
                                 :password => "",
                                 :database => "personal")

    DbApplication.connection = @connection

    @connection
      .prepare("insert into teachers (first_name, last_name, classroom) VALUES ('Brett', 'Cassette', 1000)")
      .execute
  end

  after(:all) do
    @connection
      .prepare("delete from teachers where classroom=1000")
      .execute
  end

  it "finds data" do
    result = Models::Teacher.where(:classroom => 1000)
    expect(result.first.first_name).to eq "Brett"
  end

  it "finds single records" do
    result = Models::Teacher.find(1)
    expect(result.first_name).to eq "MIN"
  end
end
