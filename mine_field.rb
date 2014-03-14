require './grid_square.rb'

class MineField
  attr_reader :board

  NEW_LINE = "\n"
  SPACE = " "

  def initialize(size, bombs, grid_square_factory = GridSquare)
    @field = new_field size, grid_square_factory 
    @bombs = bombs
    @size = size
  end

  def to_s
    field_string = generate_column_header
    field_string += field.each_with_index { |row, index| row_to_s(row, index + 1) }
  end

  def place_flag position

  end

  def draw_with_bombs
    board.each do |row|
      row.each { |square| square.set_checked }
    end
    to_s
  end

  def generate_bombs(position)
    bombs.times do
      place_bomb(position)
    end
  end

  def has_bombs
    count = 0
    board.each do |row|
      count += row.count { |square| square.bomb? }
    end
    count > 0
  end

  def check_bombs(position)
    neighbors(position).count { |neighbor_position| board[neighbor_position[:row]][neighbor_position[:col]].bomb? }
  end

  def neighbors(position)
    row = position[:row]
    col = position[:col]
    [
      {row: row-1, col: col-1},
      {row: row-1, col: col},
      {row: row-1, col: col+1},
      {row: row, col: col-1},
      {row: row, col: col+1},
      {row: row+1, col: col-1},
      {row: row+1, col: col},
      {row: row+1, col: col+1}
    ].select { |neighbor_position| valid_position neighbor_position }
  end

  def flatten_board
    board.flatten
  end
  private

  attr_reader :size, :bombs

  def new_board(grid_square_factory, size)
    Array.new(size) {Array.new(size) {grid_square_factory.new}}
  end

  def place_bomb(position)
    row = rand(size)
    col = rand(size)
    until valid_bomb_position row, col, position do
      row = rand(size)
      col = rand(size)
    end
    board[row][col].set_bomb!
  end

  def valid_bomb_position(row, col, position)
    (row != position[:row] || col != position[:col]) && !board[row][col].bomb? && neighbors(position).all? { |neighbor_position| row != neighbor_position[:row] || col != neighbor_position[:col] }
  end

  def generate_column_header
    header = row_header_width
    field.length.times { |col| header += "#{col + 1} " }
    header += NEW_LINE
  end

  def row_to_s(row, row_num)
    row_string = "#{row_num}"
    row_string += row_header_gap row_num
    row.each { |grid_square| row_string += grid_square.to_s + SPACE }
    row_string += NEW_LINE
  end

  def row_header_width
    SPACE * @size.count + SPACE
  end

  def row_header_gap row_num
    row_header_width - row_num.length
  end

  def valid_position(position)
    row = position[:row]
    col = position[:col]
    (row >= 0 and row < size) and (col >= 0 and col < size)
  end
end
