class MineField
  attr_reader :board
  def initialize(grid_square_factory, size, bombs)
    @board = new_board grid_square_factory, size
    @bombs = bombs
    @size = size
  end

  def to_s
    print_column_header
    board.each_with_index { |row, index| print_row(row, index) }
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
      {row: row, col: col},
      {row: row, col: col+1},
      {row: row+1, col: col-1},
      {row: row+1, col: col},
      {row: row+1, col: col+1}
    ].select { |neighbor_position| valid_position neighbor_position }
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

  def print_column_header
    print "  "
    board.length.times { |col| print "#{col + 1} " }
    puts
  end

  def print_row(row, index)
    print "#{index + 1} "
    row.each { |grid_square| grid_square.to_s }
    puts
  end


  def valid_position(position)
    row = position[:row]
    col = position[:col]
    (row >= 0 and row < size) and (col >= 0 and col < size)
  end
end
