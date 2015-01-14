require 'pry'

class Game

	def initialize
		@board = Board.new
		@players = [Player.new('player1', 'X'), Player.new('player2', 'O')]
		@turn = 0
	end

	def whose_turn?
		@players[@turn]
	end

	def switch_turn
		case @turn
		when 0
			@turn += 1
		when 1
			@turn -= 1
		end
	end

	def board
		puts "---"
		puts "Board"
		@board.show
		puts "---"
		puts "Turn: #{self.whose_turn?.name}"
	end

	def make_move
		player = whose_turn?
		coordinates = player.move
		
		if @board.valid_coordinates?(coordinates)
			@board.update(coordinates, player.symbol)
			if self.win?
				puts "#{player.name} (#{player.symbol}) WON"
				@board.show
			elsif self.tie?
				puts "TIED GAME!"
				@board.show
			else
				self.switch_turn
			end
		else
			puts "the coordinate you entered has already been taken"
			self.make_move
		end
	end

	def win?
		symbol = whose_turn?.symbol

		#evaluate rows
		@board.display.each do |row|
			if row.all? { |element| element == symbol }
				return true
			end
		end

		#evaluate columns
		for i in 0...@board.display.size
			evaluate = []
			for j in 0...@board.display.size
				evaluate << @board.display[j][i]
			end

			if evaluate.all? { |element| element == symbol }
				return true
			end
		end

		
		#evaluate diagonals
		evaluate = []
		for i in 0...@board.display.size
			evaluate << @board.display[i][i]
		end

		if evaluate.all? { |element| element == symbol }
			return true
		end

		evaluate = []
		i = 2
		j = 0
		while i >= 0
			evaluate << @board.display[i][j]
			i -= 1
			j += 1
		end

		if evaluate.all? { |element| element == symbol }
			return true
		end

		return false
	end

	def tie?
		@board.display.each do |row|
			if row.include?(nil)
				return false
			end
		end
		return true
	end

end

class Board < Array
	# include Enumerable

	def initialize
		@board = new_board(3)
	end

	def new_board(size)
		board = Array.new
		for i in 0...size
			board << Array.new(size)
		end
		board
	end

	def update(coordinates, symbol)
		x = coordinates[0].to_i
		y = coordinates[1].to_i
		@board[x][y] = symbol

		return @board
	end

	def show
		@board.each do |row|
			puts row.inspect
		end
	end

	def display
		@board
	end

	def valid_coordinates?(coordinates)
		x = coordinates[0].to_i
		y = coordinates[1].to_i

		if @board[x][y] == nil 
			return true
		else
			return false
		end
	end
end


class Player
	def initialize(name, symbol)
		@name = name
		@symbol = symbol
		@win = false
	end

	def name
		@name
	end

	def symbol
		@symbol
	end

	def move
		puts "Input your coordinates in format \'x,y\'"
		coordinates = gets.chomp.split(',')
		return coordinates
	end
end

def main()
	game = Game.new

	while game.win? == false and game.tie? == false
		game.board
		game.make_move
	end
end

main
