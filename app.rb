require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'

require_relative './public/wordlist'

enable :sessions

get '/' do
  variables
  erb :main
end

get '/newgame' do
  newgame
  redirect to('/')
end

post '/' do
  check_response(params[:user_guess].upcase)
  redirect to('/')
end

helpers do


  def variables
    @secret_word = session[:secret_word]
    @num_guesses = session[:num_guesses]
    @display = session[:display]
    @wrong_guesses = session[:wrong_guesses]
    @used_letters = session[:used_letters]
  end

  def newgame
    word_set = WordList.new('./public/5desk.txt').list
    session[:secret_word] = secret_word(word_set)
    session[:num_guesses] = 6
    session[:display] = display
    session[:wrong_guesses] = []
    session[:used_letters] = []
  end

  def secret_word(word_set)
    word_set.sample.upcase.split("")
  end

  def display
    Array.new(session[:secret_word].length, " _ ")
  end

  def check_response(guess)
    if used_letter?(guess)
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

end
