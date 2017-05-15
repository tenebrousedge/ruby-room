require 'bundler/setup'
require 'json'
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
        redirect "/user/"
    else
        redirect "/failure"
    end
end


#USER PATH

get '/user/' do
  #user account
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
    erb :user
  else
    erb(:failure)
  end
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

get "/signout" do
  session[:user_id] = nil
  erb :index
end

get "/failure" do
  erb :failure
end


#CHAT PATH

get '/chat/' do
  #chat page
  if session[:user_id] != nil
    @messages = Message.all
    @user_id = session[:user_id]
    erb :chat
  else
    erb(:failure)
  end
end

get '/data' do
content_type :json
Message.all.to_json
end

post '/chat/messages/new' do
  #creates a message and assigns it to the user id passed through url
  print(params)
  values = JSON.parse(request.env["rack.input"].read)
  user_id = session[:user_id]
  new_message_content = params['new-message']
  Message.create(content: new_message_content, user_id: user_id)
  # redirect back
end
