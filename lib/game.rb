class Game

  attr_accessor :board, :player_1, :player_2

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
  @player_1 = player_1
  @player_2 = player_2
  @board = board
end

def current_player
if @board.turn_count.even?
    @player_1
  else
    @player_2
end
end


  def won?
    WIN_COMBINATIONS.find do |combo|
  board.cells[combo[0]] == board.cells[combo[1]] && board.cells[combo[1]] == board.cells[combo[2]] && board.cells[combo[0]]
end
end

def draw?
    board.full? && !won? ? true : false 
  end 
  
  def over?
    (won? || draw?) ? true :false
  end 

def winner
    WIN_COMBINATIONS.each do |combo|
      x_count = 0
      o_count = 0
      combo.each do |c|
        if board.cells[c] == "X"
          x_count = x_count + 1
        elsif board.cells[c] == "O"
          o_count = o_count + 1
        end
      end
      if x_count == 3
        return "X"
      elsif o_count == 3
        return "O"
      end
    end
    return nil
  end

  def turn
    input = current_player.move(board).to_i
    puts "make a move between 1-9"
    board.valid_move?(input) ? @board.update(input, current_player) : turn
  end

  
    def play 
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end 
  end



end
