require 'bundler/setup'
Bundler.require(:default)
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


#LOGIN PATH

get '/' do
  User.create(name: 'nik', password: 'hi')
  User.create(name: 'ken', password: 'aloha')
  User.create(name: 'sean', password: 'whatever')
  User.create(name: 'tanner', password: 'haha')
  #login
  erb :index
end

get '/user/find' do


  user_id = User.find_by(name: params['user-name']).id
  redirect "/user/#{user_id}"
end


#USER PATH

get '/user/:id' do
  #user account
  @user = User.find(params['id'])

  erb :user
end

post '/user/new' do
  #creates a new user
  User.create(name: params['user-name'], password: params['user-password'])
end

patch '/user/name/:id' do
  #edits user
  User.update(name: params['new-name'], password: params['new-password'])
end

delete '/user/:id/delete' do
  #deletes a user
  User.destroy(User.find(params['id']))
end


#CHAT PATH

get '/chat/:id' do
  #chat page
  @messages = Message.all
  @user_id = params['id']

  erb :chat
end

post '/chat/:id/messages/new' do
  #creates a message and assigns it to the user id passed through url
  user_id = params['id']
  new_message_content = params['new-message']
  Message.create(content: new_message_content, user_id: user_id)
  redirect back
end
