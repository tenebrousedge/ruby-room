source("https://rubygems.org")

# gem("sinatra-contrib", :require => "sinatra/reloader")
# gem("sinatra-activerecord")
# gem("rake")
# gem("pg")
# gem("sinatra")



group(:test) do
  gem("rspec")
  gem("capybara")
  gem("shoulda-matchers", '~> 2.0')
end

group :production do
  gem("sinatra-contrib", :require => "sinatra/reloader")
  gem("sinatra-activerecord")
  gem("rake")
  gem("pg")
  gem("sinatra")
  gem("bcrypt")
end
