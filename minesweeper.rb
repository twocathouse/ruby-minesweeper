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
    input = get_user_input
    if input[0] == "f"
      position = { row: input[1].to_i - 1, col: input[2].to_i - 1 }
      flag_move position
    else
      position = { row: input[0].to_i - 1, col: input[1].to_i - 1 }
      if !board.has_bombs
        board.generate_bombs position
      end
      check_move position
    end
  end

  def check_move(position)
    num_bombs = board.check_bombs position
    board.board[position[:row]][position[:col]].set_checked! num_bombs
    if num_bombs == 0
      cascade position
    end
  end

  def flag_move(position)
    square = board.board[position[:row]][position[:col]]
    if !square.flag?
      square.flag
    elsif square.flag?
      square.unflag
    end
  end

  def cascade(position)
    board.neighbors(position).each do |neighbor_position|
      if !board.board[neighbor_position[:row]][neighbor_position[:col]].checked?
        check_move neighbor_position
      end
    end
  end

  def game_over
    win || lose
  end

  def win
    win = board.flatten_board.all? { |square| (square.bomb? || square.checked?) && !(square.bomb? && square.checked?) }
    if win
      puts "WIN"
    end
    win
  end

  def lose
    lose = board.flatten_board.any? { |square| square.bomb? && square.checked? }
    if lose
      board.draw_with_bombs
      puts "LOSE"
    end
    lose
  end

  def get_user_input
    print "Move? "
    gets.strip.split(" ")
  end

  def get_user_number_input
    gets.strip.to_i - 1
  end
end

