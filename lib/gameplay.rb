require 'ruby_figlet'
using RubyFiglet
require_relative 'hangman_art'
include HangmanStages
require "yaml"

class Game
  def initialize
    reset_variables
  end
  
  def reset_variables
    dictionary = 'lib/dictionary.txt'
    @lives = 6
    @guessed_letters = []
    @choice = ""
    @secret_word = get_word(dictionary)
    @stages = HangmanStages::STAGES
  end

  def save_game
    Dir.mkdir("saved_games") unless Dir.exist?("saved_games")
    count = Dir[File.join("saved_games", '**', '*')].count { |file| File.file?(file) }
    File.open("saved_games/game_#{count + 1}.yaml", "w") do |out|
      YAML.dump(self, out)
    end
    puts "Saving game..."
    sleep(1)
    exit
  end

  def load_game(file)
    puts "Loading game..."
    sleep(1)
    saved_game = YAML::load(File.read("saved_games/game_#{file}.yaml"), permitted_classes: [Game])
    saved_game.play_game    
  end

  def show_title
    hangman =  RubyFiglet::Figlet.new("Hang Man", 'doom').stringify
    puts hangman    
  end
  
  def welcome    
    puts "\n\nChoose from the following options:"    
    show_menu    
    print "\nYour choice: "    
    @choice = gets.chomp
    get_choice(@choice) 
  end
  
  def get_word(file)
    word = File.readlines(file).sample.strip  
    word.length.between?(5, 12) ? word.upcase : get_word(file)
  end
    
  def show_menu
    puts "\n1. Start New Game"
    puts "2. Load Saved Game"
    puts "3. Exit"
  end
  
  def get_choice(user_choice)
    case user_choice
    when "1"      
      puts "\nStarting new game...\n\n"
      sleep(1)
      system("clear")
      play_game

    when "2"
      Dir.exist?("saved_games") ? (puts Dir["saved_games/*"]) : (puts "No saved games available! Please enter 0.")
      selection = gets.chomp
      count_saved_games = Dir[File.join("saved_games", "**", "*")].count { |file| File.file?(file) }
      until ("0"..count_saved_games.to_s).include?(selection)
        puts "Invalid input or game not found. Please enter 0 for new game."
        selection = gets.chomp
      end
      selection == "0" ? play_game : load_game(selection)

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

  def get_player_input
    print "\nType '1' to save game or guess a letter: "
    guess = gets.chomp.upcase.gsub(/1cl[^A-Z]/, '')
    if guess.empty?
      puts "Please enter a valid letter (A-Z) or '1' to save the game."
      return get_player_input
    end
    guess
  end

  def play_game
    end_game = false
    display = Array.new(@secret_word.length, "_")
    
    until end_game
      show_title
      puts HangmanStages::STAGES[@lives]
      puts
      puts display.join(" ") + "\n"      
      puts "\nUsed Letters: #{@guessed_letters}"
      guess = get_player_input

      save_game if guess == "1"
      
      puts "You've already guessed #{guess}" if @guessed_letters.include?(guess)
      @guessed_letters << guess unless @guessed_letters.include?(guess)
      @secret_word.chars.each_with_index do |letter, position|
        display[position] = letter if letter == guess
      end
      
      unless @secret_word.include?(guess)        
        @lives -= 1
        puts "\nYou guessed #{guess}, thats not in the word."
        end_game = true if @lives == 0
        puts "You lose!\nThe word is #{@secret_word}.\n" if end_game
        puts
      end
      
      puts
      end_game = true if !display.include?("_")
      puts "You win! The word is #{@secret_word}" if !display.include?("_")
      sleep(2)
      system("clear")
    end
    play_again?
  end

  def play_again?
    reset_variables    
    puts "\nWould you like to play again?"
    answer = gets.chomp
    play_game if answer == 'y' || answer == 'yes'
    system("clear")
    show_title    
    puts "\nThanks for playing!"    
    puts "\nCreated by Xebros - 2024\n"
    exit
  end
end
