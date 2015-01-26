require 'pry'
require 'yaml'

class Game
	def initialize
		@word = pick_word("5desk.txt")
		@wrong_guesses = []
		@guess = initialize_guess(@word)
		@life = 5
		puts "Welcome to Hangman!"
		puts 
	end

	def word
		@word
	end

	def guess
		@guess
	end
	
	def life
		@life
	end

	def pick_word(filename)
		qualified_words = []

		File.open(filename).each do |word|
			word = word.chomp.downcase
			qualified_words << word if word.length >= 5 && word.length <= 12
		end

		random_number = Random.rand(qualified_words.size)
		
		return qualified_words[random_number]
	end

	def initialize_guess(word)
		guess = ""
		word.size.times { guess += "_" }
		return guess
	end

	def display_state
		puts "#{@guess}"
		puts "You have #{@life} life left"
		if @wrong_guesses.empty?
			puts "Wrong guesses: None"
		else
			puts "Wrong guesses: #{@wrong_guesses.join(", ")}"
		end
		puts "Guess a letter!"
	end

	def guess_letter
		gets.chomp.downcase
	end

	def make_guess
		letter = guess_letter

		if letter == "save"
			save_game
			return 0
		end

		while valid_input?(letter) == false
			letter = guess_letter
			if letter == "save"
				save_game
				return 0
			end
			# binding.pry
		end		

		index = (0...@word.length).find_all {|i| @word[i,1] == letter}
		if index.empty?
			@wrong_guesses << letter
			@life -= 1
			puts "Sorry, wrong guess."
		else
			index.each { |i| @guess[i] = letter }
		end
	end

	def valid_input?(input)
		if input == "save"
			return true
		elsif input.empty?
			puts "Sorry, you must guess a letter. Guess again!"
			return false
		elsif input.length > 1
			puts "Sorry, you cannot guess more than 1 letter at a time. Guess Again!"
			return false
		elsif input[/[a-z]/] != input
			puts "Sorry, you must enter a alphabetic character. Guess Again!"
			return false
		end
		
		return true 
	end

	def win?
		@guess.include?("_") ? false : true
	end

	def self.save_game
		Dir.mkdir('games') unless Dir.exists?('games')
		filename = 'games/saved.yaml'
		File.open(filename, 'w') do |file|
			file.puts YAML.dump(self)
		end
	end

	def self.load_game
		content = File.read("games/saved.yaml")
		YAML::load(content)
	end
end


puts "Welcome to Hangman!"
puts "Would you like to start a new game? or load the previously saved one? Enter N for new and L for load"

input = gets.chomp

input == "N" ? game = Game.new : game = Game.load_game

while !game.win?
	game.display_state
	status = game.make_guess

	if status == 0
		puts "game saved successfully"
		break
	end

	if game.win?
		puts "Congratulation, you won!"
		break
	elsif game.life <= 0
		puts "Sorry, you lost. The word was #{game.word}"
		break
	end
end


