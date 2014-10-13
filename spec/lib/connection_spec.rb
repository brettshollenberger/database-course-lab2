require "spec_helper"

describe Connection do
  before(:all) do
    @connection = Connection.new(:host => "127.0.0.1",
                                 :username => "root",
                                 :password => "",
                                 :database => "personal")
    @connection
      .prepare("insert into teachers (first_name, last_name, classroom) VALUES ('Brett', 'Cassette', 1000)")
      .execute
  end

  after(:all) do
    @connection
      .prepare("delete from teachers where classroom=1000")
      .execute
  end

  it "wraps mysql" do
    result = @connection.prepare("select first_name from teachers where classroom=1000").execute.map { |r| r }.first.first
    expect(result).to eq "Brett"
  end

  it "logs execution time" do
    result = @connection.prepare("select first_name from teachers where classroom=1000").execute
    expect(result.execution_time > 0).to be true
  end
end
