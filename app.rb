#LOGIN PATH

get '/' do
  #login
  erb :index
end


#USER PATH

get '/user/:id'
  #user account
  @user = User.find(params['id'])
  erb :user
end

post '/user/new'
  #creates a new user
  User.create(user_name: params['user-name'], user_password: params['user-password'])
end

patch '/user/name/:id' do
  #edits user 
  User.update(new_name: params['new-name'], new_password: params['new-password'])
end

delete '/user/:id/delete' do
  #deletes a user
  User.destroy(User.find(params['id']))
end


#CHAT PATH

get '/chat' do
  #chat page
  @messages = Message.all
  erb :chat
end



