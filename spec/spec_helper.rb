ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require("pg")

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM projects *;")
    DB.exec("DELETE FROM volunteers *;")
  end
end

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }
