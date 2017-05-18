require 'bundler/setup'
require 'json'
require 'pry'
Bundler.require(:default)
use Rack::Logger

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

require 'bcrypt'
enable  :sessions, :logging

#login
get '/' do
  @user = User.find_by(:uuid => session[:uuid])
  LastMessage.create(message_id: "none")
  @variable = "Your IP address is #{request.ip}"
  erb :index
end

# path to signup form
get '/signup' do
  erb :signup
end

get '/admin' do
  @users = User.all
  @exiles = Exile.all
  @variable = "Your IP address is #{request.ip}"
  erb :admin
end

# add a user to the db
post "/signup" do

  ip = request.ip
  banned_ips = []
  Exile.all.each do |exile|
    banned_ips.push(exile.address.to_s)
  end

  if banned_ips.include? ip
    redirect "/failure"
  else

    user = User.new(
    :username => params['username'],
    :password => params['password'],
    :profile_picture => "/img/no-profile-picture.jpg",
    :about_me => "no description available",
    :address => request.ip
    )

    if user.save && params['agree'] == "agree"
        redirect "/"
    else
        redirect "/failure"
    end
  end
end

# create uuid on login
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

#user account
get '/user/' do
  @user = User.find_by(:uuid => session[:uuid])
  if @user != nil && session[:uuid] != nil
    erb :user
  else
    erb(:failure)
  end
end

# path to edit a user's profile info
get '/user/profile' do
  @user = User.find_by(:uuid => session[:uuid])
  erb :profile
end

# path to edit a user's account info
get '/user/edit' do
  @user = User.find_by(:uuid => session[:uuid])
  erb :edit
end

# path to delets a user
get '/user/delete' do
  @user = User.find_by(:uuid => session[:uuid])
  erb :delete
end

#POST add infor to user profile
post '/user/profile' do
  user = User.find_by(:uuid => session[:uuid])
  profile_image = params['profile-image']
  about_me = params['about-me']
  if profile_image != ""
    user.update(profile_picture: profile_image)
  end
  if about_me != ""
    user.update(about_me: about_me)
  end
  redirect '/user/'
end

#PATCH edits a user
patch '/user/edit' do
  user = User.find_by(:uuid => session[:uuid])
  new_name = params['edit-name']
  new_password = params['edit-password']
  if new_name != ""
    user.update(username: new_name)
  end
  if new_password != ""
    user.update(password: new_password)
  end
  redirect '/user/edit'
end

#DELETE deletes a user
delete '/user/delete' do
  User.find_by(:uuid => session[:uuid]).destroy
  redirect '/'
end

#signs a user out (ending session)
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

#chat page
get '/chat/' do
  @user = User.find_by(:uuid => session[:uuid])
  if @user != nil && session[:uuid] != nil
    @user.update(activity: true)
    @messages = Message.all
    @user_id = session[:user_id]
    @admin = true
    erb :chat
  else
    erb(:failure)
  end
end


delete "/post/remove" do
  post = Message.find(params['remove-message'])
  post.destroy
  redirect back
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

#JSON DATA SERVING
get '/active-users' do
  content_type :json
  HashMash.active_users.to_json
end

post '/data' do
  lastMessage = JSON.parse(request.env["rack.input"].read)
  last_stored_message = LastMessage.find_by(:id => 1)
  last_stored_message.update(message_id: lastMessage)
  redirect '/data'
end


delete '/message/:id/delete' do
  message = Message.find(params['id'])
  message.destroy()
  redirect back
end

post '/message/delete' do
  json_string = JSON.parse(request.env["rack.input"].read)
  message = Message.find(json_string)
  message.destroy()
end

post '/user/:id/ban' do
  id = params['id']
  user = User.find_by id: id
  Message.all.each do |message|
    if message.user_id == id
      message.destroy()
    end
  end
  address = user.address
  Exile.create(username: user.username, address: address)
  user.destroy()
  redirect back
end
