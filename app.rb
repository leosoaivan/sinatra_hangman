require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'

require_relative './public/wordlist'

enable :sessions

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

helpers do

  def variables
    @secret_word = session[:secret_word]
    @num_guesses = session[:num_guesses]
    @display = session[:display]
    @wrong_guesses = session[:wrong_guesses]
    @used_letters = session[:used_letters]
    @message = session[:message]
  end

  def newgame
    word_set = WordList.new('./public/5desk.txt').list
    session[:secret_word] = secret_word(word_set)
    session[:num_guesses] = 6
    session[:display] = display
    session[:wrong_guesses] = []
    session[:used_letters] = []
    session[:message] = ""
  end

  def secret_word(word_set)
    word_set.sample.upcase.split("")
  end

  def display
    display = Array.new(session[:secret_word].length, " _ ")
  end

  def check_response(guess)
    if used_letter?(guess)
      session[:message] = "Motherf*!@r, you already tried that letter. Play better."
      return
    else
      evaluate_guess(guess)
    end
  end

  def used_letter?(guess)
    session[:used_letters].include?(guess) ? true : false
  end

  def evaluate_guess(guess)
    if session[:secret_word].include?(guess)
      session[:secret_word].each_with_index do |el, ind|
        if guess == el
          session[:display][ind] = guess
        end
      end
    else
      session[:wrong_guesses] << guess
      session[:num_guesses] -= 1
    end
    session[:used_letters] << guess
  end

  def check_game
    if session[:num_guesses] == 0
      session[:message] = "You lost and you should feel bad. Your word was #{session[:secret_word].join("")}."
      redirect to('/lost')
    end
    if !session[:display].include?(" _ ")
      session[:message] = "Aced it, mate. And you did it with #{6 - session[:num_guesses]} wrong guess(es)."
      redirect to ('/won')
    end
  end

end
