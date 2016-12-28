require './dictionary.rb'
require 'json'

class Game
  def initialize
    @word_set = Dictionary.clean('5desk.txt')
    @word = @word_set.sample.upcase.split("")
    @blanks = Array.new(@word.length, "_ ")
    @user_guess = ""
    @letter_index = []
    @wrong_ary = []
    @game_won = false
    @@guesses = 6
    game_execute
  end

  private

  def game_execute
    game_loop
    ending_msg
    restart
  end

  def start_message
    puts "*********************************************************************"
    puts "*                            HANGMAN                                *"
    puts "*                                                                   *"
    puts "*      Welcome to a command line implementation of the classic      *"
    puts "* game, written in Ruby! Try to guess the secret word, but beware:  *"
    puts "*                 You only have 6 wrong guesses!                    *"
    puts "*                                                                   *"
    puts "*   You can save and load at anytime. Just type 'save' or 'load'    *"
    puts "*        (without quotes). To quit, type 'quit' at any time!        *"
    puts "*********************************************************************"
  end

  def game_loop
    begin
      system "clear"
      start_message
      update_blanks
      blank_lines
      remaining_guesses
      wrong_guesses
      break if !@blanks.include?("_ ")
      prompt_guess
      evaluate_guess
    end until @@guesses == 0
  end

  def blank_lines
    puts ""
    print "Your word:  "
    puts "#{@blanks.join}"
    puts ""
  end

  def wrong_guesses
    print "Your wrong guesses: "
    puts @wrong_ary.sort.join(" ")
    puts ""
  end

  def remaining_guesses
    puts "You have #{@@guesses} wrong guess(es) left."
  end

  def prompt_guess
    begin
      print "Your guess: "
      @user_guess = gets.chomp.upcase
    end until /[A-Z]/.match(@user_guess)
  end

  def evaluate_guess
    if @user_guess == "SAVE"
      puts "Your file has been saved!"
      sleep(1.5)
      save_function
    elsif @user_guess == "LOAD"
      load_function
    elsif @user_guess == "QUIT"
      abort("Goodbye. Thanks for playing!")
    else
      @user_guess = @user_guess[0]
      evaluate_input
    end
  end

  def evaluate_input
    @word.include?(@user_guess) ? index_matches : tally_wrong
  end

  def index_matches
    @word.each_with_index { |el, ind| @letter_index << ind if el == @user_guess }
  end

  def tally_wrong
    @wrong_ary << @user_guess
    @@guesses -= 1
  end

  def update_blanks
    @letter_index.each { |num| @blanks[num] = "#{@user_guess} "}
    @letter_index.clear
  end

  def save_function
    Dir.mkdir("save") unless Dir.exists?("save")

    filename = "save/saved_game.json"

    File.open(filename,'w') do |file|
      file.puts to_json
    end
  end

  def to_json
    JSON.dump({
      "word" => @word,
      "blanks" => @blanks,
      "wrong_ary" => @wrong_ary,
      "game_won" => @game_won,
      "guesses" => @@guesses
    })
  end

  def load_function
    if File.exists?("save/saved_game.json")
      loaded = JSON.load File.new("save/saved_game.json")
      from_json(loaded)
      puts "Your file is being loaded."
      sleep(1.5)
    else
      puts "There is no save file!"
      sleep(1.5)
    end
  end

  def from_json(json)
    @word = json["word"]
    @blanks = json["blanks"]
    @wrong_ary = json["wrong_ary"]
    @game_won = json["game_won"]
    @@guesses = json["guesses"]
  end

  def ending_msg
    if @@guesses == 0
      puts "You lost the game!"
      puts "The secret word was #{@word.join.upcase}."
    else
      puts "You won the game!"
    end
    puts ""
  end

  def restart
    print "Would you like to play again? Y/N? "
    input = gets.chomp.upcase

    if input == "Y"
      x = Game.new
    elsif input == "N"
      puts "Goodbye!"
    else
      puts "I didn't get that."
      restart
    end
  end

end

x = Game.new
