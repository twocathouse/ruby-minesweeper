class Minesweeper

  def initialize(board)
    @board = board
  end

  def play
    until game_over do
      @board.to_s
      make_move
    end
  end

  private

  attr_reader :board

  def make_move
    position = get_user_input
    if !@board.has_bombs
      @board.generate_bombs position
    end
    check_move position
  end

  def check_move(position)
    num_bombs = board.check_bombs position
    board.board[position[:row]][position[:col]].set_checked! num_bombs
    cascade position
  end

  def cascade(position)
    board.neighbors(position).each do |neighbor_position|
      until board.check_bombs(neighbor_position) > 0
        puts neighbor_position
        check_move neighbor_position
      end
    end
  end

  def game_over
    win || lose
  end

  def win

  end

  def lose

  end

  def get_user_input
    print "Row? "
    row = get_user_number_input
    print "Column? "
    col = get_user_number_input
    return {row: row, col: col}
  end

  def get_user_number_input
    gets.strip.to_i - 1
  end
end

