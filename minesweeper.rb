require './mine_field.rb'
require './user_input.rb'

class Minesweeper

  def initialize(size, bombs, field = MineField, input = UserInput.new)
    @field = field.new size, bombs
    @user_input = input
  end

  def play
    until game_over do
      draw_board
      make_move
    end
  end

  private

  attr_reader :field, :user_input

  def draw_board
    puts field.to_s
  end

  def make_move
    input = get_user_input
    mark_square input
  end

  def mark_square input
    if input.flag?
      field.place_flag input.position
    else
      make_normal_move input.position
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
    input = user_input.gets
  end

  def get_user_number_input
    gets.strip.to_i - 1
  end
end

