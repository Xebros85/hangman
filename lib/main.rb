
# word length between 5 and 12 characters

file_path = 'dictionary.txt'

def get_word(file_path)
  word = File.readlines(file_path).sample.strip
  puts "Word length: #{word.length}"
  if word.length >= 5 && word.length <= 12
    word
  else
    get_word(file_path)
  end
end

secret_word = get_word(file_path)
puts secret_word
puts "Secret Word Length: #{secret_word.length}"