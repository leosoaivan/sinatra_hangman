module HelperUtils
  def variables
    @secret_word = session[:secret_word]
    @num_guesses = session[:num_guesses]
    @blank_display = session[:blank_display]
    @wrong_guesses = session[:wrong_guesses]
    @used_letters = session[:used_letters]
    @message = session[:message]
  end

  def newgame
    word_set = TextParser.new(File.new('assets/5desk.txt')).parsed
    word = WordChooser.new(word_set)
    session[:secret_word] = word.secret_word
    session[:secret_letters] = word.secret_letters
    session[:num_guesses] = 6
    session[:blank_display] = display(word.secret_letters)
    session[:wrong_guesses] = []
    session[:used_letters] = []
    session[:message] = ""
  end

  def display(array)
    Array.new(array.length, " _ ")
  end

  def check_response(guess)
    if used_letter?(guess)
      session[:message] = "You already tried that letter. Try harder."
      return
    else
      evaluate_guess(guess)
    end
  end

  def used_letter?(guess)
    session[:used_letters].include?(guess) ? true : false
  end

  def evaluate_guess(guess)
    if session[:secret_letters].include?(guess)
      guess_indexer(guess).each do |match|
        session[:blank_display][match] = guess
      end
    else
      session[:wrong_guesses] << guess
      session[:num_guesses] -= 1
    end
    session[:used_letters] << guess
  end

  def guess_indexer(guess)
    session[:secret_letters].each_index.select do |ind|
      session[:secret_letters][ind] == guess
    end
  end

  def check_game
    if session[:num_guesses] == 0
      session[:message] = "You lost and you should feel bad. Your word was #{session[:secret_word]}."

      redirect to('/lost')
    end
    if !session[:blank_display].include?(" _ ")
      session[:message] = "Aced it! The word was #{session[:secret_word]} and you guessed it with #{session[:num_guesses]} guess(es) left."
      
      redirect to ('/won')
    end
  end
end