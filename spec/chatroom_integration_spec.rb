require 'spec_helper'
require 'integration_spec_helper'
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the user path', {:type => :feature}) do
  it('allows a user to add a username and password') do
    visit('/')
    click_link('Create New Account')
    fill_in('username', :with =>'hello')
    fill_in('password', :with =>'world')
    click_button('Send')
    fill_in('username', :with =>'hello')
    fill_in('password', :with =>'world')
    click_button('Login')
    expect(page).to have_content('hello')
  end

  it 'allows the user to log and see chatroom' do
    # CreateData.create_user
    visit('/')
    click_link('Create New Account')
    fill_in('username', :with =>'eric')
    fill_in('password', :with =>'clapton')
    click_button('Send')
    fill_in('username', :with =>'eric')
    fill_in('password', :with =>'clapton')
    click_button('Login')
    expect(page).to have_content 'eric' 
    click_link 'chatroom'
    expect(page).to have_content 'Users in the chat' 
  end

  it 'allows the user to sign out' do
    visit('/')
    click_link('Create New Account')
    fill_in('username', :with =>'eric')
    fill_in('password', :with =>'clapton')
    click_button('Send')
    fill_in('username', :with =>'eric')
    fill_in('password', :with =>'clapton')
    click_button('Login')
    click_link 'chatroom'
    click_link 'Sign Out'
    expect(page).to have_content 'Login'
  end
end
