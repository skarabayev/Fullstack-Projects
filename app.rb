require 'sinatra'
require_relative 'my_user_model.rb'

set :bind, '0.0.0.0'
set  :port, '8080'
enable  :sessions

get '/users' do
    user = User.new()
    @users = user.all()
    erb  :index
end

post '/users' do
    user = Users.new()
    user_info = [params['firstname'],params['lastname'],params['age'],params['password'],params['email'],]
    id = user.create(user_info)
    "Logged user with id - #{id[0][0]}"
end

post '/sign_in' do
    user = Users.new()
    id = user.match(params['email'],params['password'])
    session[:user_id] =id[0][0]
end

put '/users' do
    user = User.new()
    id = session[:user_id]
    if id
        user.update(id,'password',params['password'])
        p "User info updated."
    else
        p "Not authorized"
    end 
end

delete '/users' do
    user = User.new()
    id = session[:user_id]
    if id
        user.destroy(id)
        session.delete('user_id')
        p "User removed."
    else
        p "Not authorized"
    end 
end

delete '/sign_out' do
    user = User.new()
    id = session[:user_id]
    if id
        session.delete('user_id')
    else
        p "Not authorized"
    end 
end