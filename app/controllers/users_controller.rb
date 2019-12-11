require 'pry'
class UsersController < ApplicationController


    get '/signup' do 
        if logged_in?
          redirect to '/tweets'
        else 
        erb :'/users/signup'
        end
    end

      post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          #redirect '/tweets'
          @user = User.new(user_params)
          @user.save
          session[:user_id] = @user.id 
          redirect '/tweets'
        end
      end

get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      binding.pry
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get "/tweets" do 
    
      erb :"/tweets/index"
end

  private

    def user_params
      {:username => params[:username], :email => params[:email], :password => params[:password]}
    end

end
