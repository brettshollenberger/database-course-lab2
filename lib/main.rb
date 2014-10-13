#!/usr/bin/env ruby

Dir[File.expand_path(File.join(__FILE__, "../**/*.rb"))].each { |f| require f }

DbApplication.connection = Connection.new(:host => "127.0.0.1",
                                          :username => "root",
                                          :password => "",
                                          :database => "personal")

Runner.run
