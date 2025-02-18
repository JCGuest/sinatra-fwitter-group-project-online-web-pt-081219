require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_fwatter"
  end

  get '/' do 
    erb :home
  end

  helpers do 

    # def logged_in?
    #   !!current_user
    # end

    # def current_user
    #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # end

    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      unless logged_in?
        redirect '/login'
      end
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
 