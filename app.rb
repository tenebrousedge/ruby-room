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
  # prefer the short hash syntax
  @user = User.find_by(uuid: session[:uuid])
  LastMessage.find_or_create_by(id: 1)
  @variable = "Your IP address is #{request.ip}"
  erb :index
end

# path to signup form
get '/signup' do
  erb :signup
end

get '/admin' do
  user = User.find_by(uuid: session[:uuid])
  # use the safe navigation operator, and test for truth implicitly
  if user&.admin
    @users = User.all
    @exiles = Exile.all
    @variable = "Your IP address is #{request.ip}"
    erb :admin
  else
    erb :failure
  end
end

# add a user to the db
# use single quoted strings unless you need special characters or interpolation
post '/signup' do

  ip = request.ip
  # use map instead of each
  banned_ips = Exile.all.map { |e| e.address.to_s }
  # one line conditionals should be written this way
  redirect '/failure' if banned_ips.include? ip
  # there's rarely any use for else statements

  
  user = User.new(
  # always use fetch to get parameters
  # using hash access for keys that are not present will return nil, where fetch will throw an error
  # you want your app to fail hard and fast when required params are missing
  # you do NOT want your app to even think about writing bad data to the database
  username: params.fetch('username'),
  password: params.fetch('password'),
  # form fields should be structured
  # user[username]
  # user[password]
  # this will produce the following in the parameters array:
  # { 'user' => { 'username' => $VALUE, 'password' => $VALUE }}
  # then you can do user = User.new(params.fetch('user'))
  profile_picture: '/img/no-profile-picture.jpg', # default values should be set in the model or database
  about_me: "no description available", # ditto
  address: ip,
  admin: false
  )
  # again, eliminate the else statement and use the conditional at the end of the line
  redirect '/failure' unless user.save && params['agree'] == 'agree'
  
  redirect '/'

end

# create uuid on login
post '/login' do
  # most of this code belongs in the model
  # no, we were never taught anything particularly useful about what code belongs in the model and what belongs here
  user = User.find_by(username: params.fetch(:username))
  redirect '/failure' unless user&.authenticate(params.fetch(:password)

  session[:user_id] = user.id
  uuid = UUID.new.to_s
  user.update(uuid: uuid)
  session[:uuid] = uuid # there's no particularly good reason to do this. 
  # If you want UUIDs, have the table use those as the primary key
  # the session id should be the same as the user id
  # this was a pretty poor decision
  redirect '/user/'
end

#user account
get '/user/' do
  @user = User.find_by(uuid: session[:uuid])
  # don't test for truthy/falsy explicitly
  # else statements are useless
  erb :failure unless @user && session[:uuid]  
  erb :user
  end
end

# path to edit a user's profile info
get '/user/profile' do
  @user = User.find_by(uuid: session[:uuid])
  erb :profile
end

# path to edit a user's account info
get '/user/edit' do
  @user = User.find_by(uuid: session[:uuid])
  erb :edit
end

# path to delets a user
get '/user/delete' do
  @user = User.find_by(uuid: session[:uuid])
  erb :delete
end

#POST add infor to user profile
post '/user/profile' do
  # uuid is begging to be the primary key
  user = User.find_by(uuid: session[:uuid])
  profile_image = params.fetch('profile-image')
  about_me = params.fetch('about-me')
  # you can update both of these things in the same method call
  # for that matter you can simply pass the id to update as the first parameter
  # validating that the profile-image and about-me are present should happen in the model
  # the rule is, 'thin controllers and fat models'
  user.update(profile_picture: profile_image) unless profile_image.blank?
  user.update(about_me: about_me) unless about_me.blank?
  redirect '/user/'
end

#PATCH edits a user
patch '/user/edit' do
  user = User.find_by(uuid: session[:uuid])
  new_name = params.fetch('edit-name')
  new_password = params.fetch('edit-password')
  # again, this is validation and belongs in the model
  # you should probably also use validation on the form itself
  user.update(username: new_name) unless new_name.blank? 
  user.update(password: new_password) unless new_password.blank?
  redirect '/user/edit'
end

#DELETE deletes a user
delete '/user/delete' do
  User.find_by(uuid: session[:uuid]).destroy
  redirect '/'
end

#signs a user out (ending session)
get "/signout" do
  user = User.find_by(uuid: session[:uuid])
  user.update(activity: false)
  user.update(uuid: '') # wat
  session[:user_id] = nil # this should be all that is necessary
  erb :index
end


get "/failure" do
  erb :failure
end

#chat page
get '/chat/' do
  @user = User.find_by(uuid: session[:uuid])
  erb :failure unless @user && session[:uuid]
  @user != nil && session[:uuid] != nil
  @user.update(activity: true)
  @messages = Message.all
  @user_id = session[:user_id]
  erb :chat
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



post '/chat/messages/new' do
  #creates a message and assigns it to the user id passed through url
  json_string = JSON.parse(request.env['rack.input'].read)
  values = json_string.split('~||~')
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

get '/data' do
  last_stored_message = LastMessage.find_by(id: '1')['message_id']
  content_type :json
  HashMash.mash_the_hash(last_stored_message).to_json
end

post '/data' do
  lastMessage = JSON.parse(request.env['rack.input'].read)
  # last message should not be a class. You should instead have a '.last' method on Message
  last_stored_message = LastMessage.find(1)
  last_stored_message.update(message_id: lastMessage)
  redirect '/data'
end


#MESSAGE CRUD

delete '/message/:id/delete' do
  message = Message.find(params['id'])
  message.destroy
  redirect back
end

post '/message/delete' do
  json_string = JSON.parse(request.env['rack.input'].read)
  message = Message.find(json_string)
  message.destroy
end

post '/user/:id/ban' do |id|
  # you can set your relations to destroy associated records automatically if the referenced user goes away
  # (and you should, because that code belongs in the model)
  user = User.find(id)
  user.messages.destroy_all
  # don't create variables if you only use them once -- this has performance effects in all languages
  # you really should have just had a status field in your user model which could be set to 'banned' or 'active'
  Exile.create(username: user.username, address: user.address) 
  user.destroy
  redirect back
end
