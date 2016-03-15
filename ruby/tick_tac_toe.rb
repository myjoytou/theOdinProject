class Array
  def any_empty?
    self.any? {|element| element.to_s.empty?}
  end

  def none_empty?
    !any_empty?
  end

  def all_empty?
    self.all? {|element| element.to_s.empty?}
  end

  def all_same?
    self.all? {|element| element == self[0]}
  end
end

class Cell
  attr_accessor :value
  def initialize(value = "")
    @value = value
  end
end

class Player
  attr_reader :player_name
  attr_reader :player_symbol
  def initialize(input)
    @player_name = input.fetch(:player_name)
    @player_symbol = input.fetch(:player_symbol)
  end
end

class Board
  attr_reader :grid
  def initialize
    @grid = default_grid
  end

  def default_grid
    Array.new(3) {Array.new(3) {Cell.new}}
  end

  def get_cell(x, y)
    grid[x][y]
  end

  def set_cell(x, y, value)
    get_cell(x,y).value = value
  end

  def check_availability(x, y)
    get_cell(x, y).value.empty?
  end

  def format_grid
    grid.each do |row|
      puts row.map {|cell| cell.value.empty? ? "_" : cell.value }.join(" ")
    end
  end

  def game_over
    return :winner if winner?
    return :draw if draw?
    false    
  end

  def draw?
    grid.flatten.map {|cell| cell.value}.none_empty?
  end

  def winning_positions
    grid + grid.transpose + diagonals
  end

  def diagonals
    [
      [get_cell(0,0), get_cell(1,1), get_cell(2,2)],
      [get_cell(0,2), get_cell(1,1), get_cell(2,0)]
    ]
  end

  def winner?
    winning_positions.each do |winning_position|
      next if winning_positions_values(winning_position).all_empty?
      return true if winning_positions_values(winning_position).all_same?
    end
    false
  end

  def winning_positions_values(winning_position)
    winning_position.map {|cell| cell.value}
  end
end


class Game
  attr_reader :players, :board, :current_player, :other_player
  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end
  
  def get_move(move = gets.chomp)
    move_to_coordinate(move)
  end

  def switch_player
    @current_player, @other_player = @other_player, @current_player
  end

  def solicit_move
    "#{current_player.player_name}: Enter a number between 1 to 9 to make your move"
  end

  def move_to_coordinate(move)
    mapping = {
      "1" => [0,0],
      "2" => [0,1],
      "3" => [0,2],
      "4" => [1,0],
      "5" => [1,1],
      "6" => [1,2],
      "7" => [2,0],
      "8" => [2,1],
      "9" => [2,2],
    }
    mapping[move]
  end
    
  def game_over_message
    return "#{current_player.player_name} wins!" if board.game_over == :winner
    return "Its a tie" if board.game_over == :draw
  end

  def play
    puts "#{current_player.player_name} has been randomly selected as the first player"
    while true
      board.format_grid
      puts ""
      puts solicit_move
      x, y = get_move
      available = board.check_availability(x, y)
      if available
        board.set_cell(x, y, current_player.player_symbol)
        if board.game_over
          puts game_over_message
          board.format_grid
          return
        else
          switch_player
        end
      else
        puts "Sorry the position is already occupied"
      end
    end
  end
end

puts "Welcome to tic tac toe game"
vivek = Player.new({player_name: "Vivek", player_symbol: "X"})
ajeet = Player.new({player_name: "Ajeet", player_symbol: "O"})
players = [vivek, ajeet]
Game.new(players).play
