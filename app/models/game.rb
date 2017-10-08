class Game
  attr_reader :wordlist, :session

  def initialize(wordlist)
    words = Wordlist.new(wordlist.readlines)
    session = {
      secret_word: sampler(words),
      num_guesses: 6,
      display: display,
      wrong_guesses: [],
      used_letters: [],
      message: ""                               
    }
  end

  def sampler(words)
    words.sample.upcase.split("")
  end

  def display
    Array.new(session[:secret_word].length, " _ ")
  end

  def check_response(guess)
    if used_letter?(guess)
      session[:message] = "Listen, you already tried that letter. Try...harder."
      return
    else
      evaluate_guess(guess)
    end
  end

  def check_game
    str = session[:secret_word].join("")
    if session[:num_guesses] == 0
      session[:message] = "You lost and you should feel bad. Your word was #{str}."
      redirect to('/lost')
    end
    if !session[:display].include?(" _ ")
      session[:message] = "Aced it! The word was #{str} and you guessed it with #{session[:num_guesses]} guess(es) left."
      redirect to ('/won')
    end
  end

  private

  def used_letter?(guess)
    session[:used_letters].include?(guess) ? true : false
  end

  def evaluate_guess(guess)
    if session[:secret_word].include?(guess)
      right_guess(guess)
    else
      wrong_guess(guess)
    end
    session[:used_letters] << guess
  end

  def right_guess(guess)
    session[:secret_word].each_with_index do |letter, index|
      session[:display][index] = guess if guess == letter
    end
  end

  def wrong_guess(guess)
    session[:wrong_guesses] << guess
    session[:num_guesses] -= 1
  end