require './mine_field.rb'
require './grid_square.rb'
require './minesweeper.rb'

board = MineField.new(GridSquare, 8, 10)
minesweeper = Minesweeper.new(board)
minesweeper.play
