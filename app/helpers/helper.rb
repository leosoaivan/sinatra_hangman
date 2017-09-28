module HelperUtils
  def variables
    @secret_word = session[:secret_word]
    @num_guesses = session[:num_guesses]
    @display = session[:display]
    @wrong_guesses = session[:wrong_guesses]
    @used_letters = session[:used_letters]
    @message = session[:message]
  end

  def newgame
    word_set = WordList.new(File.new('./assets/5desk.txt').readlines).to_edited_a
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
end