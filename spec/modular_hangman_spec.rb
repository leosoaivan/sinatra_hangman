ENV['RACK_ENV'] = 'test'

require './modular_hangman'
require 'rspec'
require 'rack/test'

xdescribe 'Hangman' do
  def app
    Sinatra::Application
  end

  xdescribe '#get' do
  end

end