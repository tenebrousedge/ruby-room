# require('capybara/rspec')
# require('./app')
# Capybara.app = Sinatra::Application
# set(:show_exceptions, false)

# describe('adding a new user', {:type => :feature}) do
#   it('allows a user to add a username and password') do
#     visit('/')
#     click_link('Create New Account')
#     fill_in('username', :with =>'Test User')
#     fill_in('password', :with =>'Password')
#     click_button('Send')
#     fill_in('username', :with =>'Test User')
#     fill_in('password', :with =>'Password')
#     click_button('Login')
#     expect(page).to have_content('Test User')
#     expect(page).to have_content('Password:')
#     click_link('Go to chatroom')
#   end
# end
