require 'bundler/setup'
require 'json'
require 'pry'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

require 'bcrypt'
enable  :sessions, :logging
#LOGIN PATH

get '/' do
  #login
  @user = User.find_by(:uuid => session[:uuid])
  erb :index
end

get '/signup' do
  erb :signup
end

post "/signup" do
    user = User.new(:username => params['username'], :password => params['password'])
    if user.save && params['agree'] == "agree"
        redirect "/"
    else
        redirect "/failure"
    end
end

post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        uuid = UUID.new.to_s
        user.update(uuid: uuid)
        session[:uuid] = uuid
        redirect "/user/"
    else
        redirect "/failure"
    end
end


#USER PATH

get '/user/' do
  #user account
  @user = User.find_by(:uuid => session[:uuid])
  if @user != nil
    erb :user
  else
    erb(:failure)
  end
end

delete '/user/:id/delete' do
  #deletes a user
  User.destroy(User.find(params['id']))
end

get "/signout" do
  user = User.find_by(:uuid => session[:uuid])
  user.update(activity: false)
  user.update(uuid: "")
  session[:user_id] = nil
  erb :index
end

get "/failure" do
  erb :failure
end


#CHAT PATH

get '/chat/' do
  #chat page
  @user = User.find_by(:uuid => session[:uuid])
  if @user != nil
    @user.update(activity: true)
    @messages = Message.all
    @user_id = session[:user_id]
    erb :chat
  else
    erb(:failure)
  end
end

get '/active-users' do
  content_type :json
  HashMash.active_users.to_json
end

get '/data' do
  content_type :json
  HashMash.mash_the_hash.to_json
end

post '/chat/messages/new' do
  #creates a message and assigns it to the user id passed through url
  json_string = JSON.parse(request.env["rack.input"].read)
  values = json_string.split("~||~")
  Message.create(
    content: values[0],
    user_id: values[1],
    display_time: Time.new.in_time_zone('Pacific Time (US & Canada)').strftime("%I:%M %P")
  )
end
