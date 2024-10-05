
# word length between 5 and 12 characters

dictionary = 'dictionary.txt'

def get_word(file)
  word = File.readlines(file).sample.strip  
  word.length.between?(5, 12) ? word : get_word(file)
end

secret_word = get_word(dictionary)
puts secret_word
puts "Secret Word Length: #{secret_word.length}"