require 'sinatra/base'
require 'pry'
require './app/models/wordchooser'
require './app/models/textparser'
require './app/helpers/helper'

class Hangman < Sinatra::Base

  set :root, File.expand_path(__dir__)
  set :public_folder, Proc.new { File.join(settings.root, "assets") }
  set :views, Proc.new { File.join(settings.root, "app/views") }

  enable :sessions, :logging

  helpers HelperUtils
  
  get '/' do
    if variables.nil?
      newgame
    end
    variables

    erb :main
  end
  
  get '/newgame' do
    newgame
    redirect to('/')
  end
  
  get '/lost' do
    variables
    erb :lost
  end
  
  get '/won' do
    variables
    erb :won
  end
  
  post '/' do
    session[:message] = ""
    check_response(params[:user_guess].upcase)
    check_game
    redirect to('/')
  end
end