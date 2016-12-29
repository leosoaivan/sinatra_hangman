require 'sinatra'
require 'sinatra/reloader' if development?

require_relative './lib/wordlist'

enable :sessions

get '/' do
  new_game
  session[:display]
end

helpers do

  def new_game
    word_set = WordList.new('./public/5desk.txt').list
    session[:secret_word] = secret_word(word_set)
    session[:guesses] = 6
    session[:display] = display
    session[:wrong_guesses] = []
  end

  def secret_word(word_set)
    word_set.sample.upcase.split("")
  end

  def display
    Array.new(session[:secret_word].length, " _ ")
  end

end
