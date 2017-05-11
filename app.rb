require 'bundler/setup'
require 'pry'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

require 'bcrypt'
enable  :sessions, :logging
#LOGIN PATH

get '/' do
  #login
  erb :index
end

get '/signup' do
  erb :signup
end

post "/signup" do
    user = User.new(:username => params['username'], :password => params['password'])
    if user.save
        redirect "/"
    else
        redirect "/failure"
    end
end

post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/user/#{user.id}"
    else
        redirect "/failure"
    end
end


#USER PATH

get '/user/:id' do
  #user account
  @user = User.find(params['id'])

  erb :user
end

post '/user/new' do
  #creates a new user
  User.create(username: params['user-name'], password: params['user-password'])
end

patch '/user/name/:id' do
  #edits user
  User.update(username: params['new-name'], password: params['new-password'])
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
