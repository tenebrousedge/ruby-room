ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end



RSpec.configure do |config|
  config.after(:each) do
    User.all.each do |d|
      d.destroy
    end
    Message.all.each do |d|
      d.destroy
    end
  end
end


Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }
