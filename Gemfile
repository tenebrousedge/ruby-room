source("https://rubygems.org")

gem("sinatra-contrib", :require => "sinatra/reloader")
gem("sinatra-activerecord")
gem("rake")
gem("pg")
gem("sinatra")
gem("shoulda-matchers", '~> 2.0')
gem("bcrypt")

group(:test) do
  gem("rspec")
  gem("capybara")
end

group :production do
  gem("sinatra-contrib", :require => "sinatra/reloader")
  gem("sinatra-activerecord")
  gem("rake")
  gem("pg")
  gem("sinatra")
end
