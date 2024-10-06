require 'ruby_figlet'
using RubyFiglet

class Game
  def initialize
    dictionary = './dictionary.txt'
    @lives = 6
    @guessed_letters = []
    @secret_word = get_word(dictionary)
  end
  
  def welcome
    hangman =  RubyFiglet::Figlet.new("Hang Man", 'doom').stringify
    puts hangman
    puts
    puts "Welcome! Choose from the following options:"
    puts
    show_menu
  end
  
  def get_word(file)
    word = File.readlines(file).sample.strip  
    word.length.between?(5, 12) ? word.upcase : get_word(file)
  end
  
  def play_game
    welcome  
  end
end

def show_menu
  puts "1. Start New Game"
  puts "2. Load Saved Game"
  puts "3. Exit"
end

# secret_word = get_word(dictionary)
# puts secret_word
# puts "Secret Word Length: #{secret_word.length}"

game = Game.new
game.play_game