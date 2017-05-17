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
  if @user != nil && session[:uuid] != nil
    erb :user
  else
    erb(:failure)
  end
end

get '/user/edit' do
  @user = User.find_by(:uuid => session[:uuid])
  erb :edit
end

get '/user/delete' do
  @user = User.find_by(:uuid => session[:uuid])
  erb :delete
end

#edits a user
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

#deletes a user
delete '/user/delete' do
  User.find_by(:uuid => session[:uuid]).destroy
  redirect '/'
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

helpers do
    def log(call,msg = '')
        severity = Logger.const_get(call.upcase)
        return if LOGGER.level > severity

        msg = yield if block_given?
        LOGGER.send(call, "<#{request.ip}> #{msg}")
    end
end
