require 'ruby_figlet'
using RubyFiglet
require_relative 'hangman_art'
include HangmanStages

class Game
  def initialize
    dictionary = './dictionary.txt'
    @lives = 6
    @guessed_letters = []
    @choice = ""
    @secret_word = get_word(dictionary)
    @stages = HangmanStages::STAGES
  end

  def show_title
    hangman =  RubyFiglet::Figlet.new("Hang Man", 'doom').stringify
    puts hangman    
  end
  
  def welcome    
    puts "\n\nChoose from the following options:"
    puts
    show_menu
    puts
    print "Your choice: "    
    @choice = gets.chomp
    get_choice(@choice) 
  end
  
  def get_word(file)
    word = File.readlines(file).sample.strip  
    word.length.between?(5, 12) ? word.upcase : get_word(file)
  end
  
  
  def show_menu
    puts "1. Start New Game"
    puts "2. Load Saved Game"
    puts "3. Exit"
  end
  
  def get_choice(user_choice)
    case user_choice
    when "1"      
      puts "\nStarting new game...\n\n"
      sleep(1)
      # start_game      
    when "2"      
      puts "\nLoading Game...\n\n"
      # load game function to load from a YAML file
      exit
    when "3"      
      puts "\nExiting...\n\n"
      sleep(0.5)      
    else
      puts "\nInvalid choice. Please choose from the menu options."
      sleep(0.75)
      system("clear")
      welcome
    end    
  end
  
  def start_game
    show_title
    welcome
       
  end
  
end

# secret_word = get_word(dictionary)
# puts secret_word
# puts "Secret Word Length: #{secret_word.length}"

game = Game.new
game.start_game