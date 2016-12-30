require 'sinatra'
require 'sinatra/reloader' if development?

require_relative './public/wordlist'

enable :sessions
word_set = WordList.new('./public/5desk.txt').list

get '/' do
  variables
  erb :main
end

post '/' do
  evaluate_guess(params[:user_guess].upcase)
  redirect to("/")
end

helpers do

  def variables
    @secret_word = session[:secret_word]
    @num_guesses = session[:num_guesses]
    @display = session[:display]
    @wrong_guesses = session[:wrong_guesses]
    @used_letters = session[:used_letters]
  end

  def game
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

  def evaluate_guess(user_guess)
    if session[:secret_word].include?(user_guess)
      secret_index_matching(user_guess)
      session[:used_letters] << user_guess
    else
      tally_wrong(user_guess)
      session[:used_letters] << user_guess
    end
  end

  #Updates the display with correct letters at the correct index
  def secret_index_matching(user_guess)
    session[:secret_word].each_with_index do |el, ind|
      if user_guess == el
        session[:display][ind] = user_guess
      end
    end
  end

  def tally_wrong(user_guess)
    session[:wrong_guesses] << user_guess
    session[:num_guesses] -= 1
  end


end
