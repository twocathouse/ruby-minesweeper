require 'colorize'

class GridSquare

  UNCHECKED = "+".freeze
  BOMB = "B".freeze

  COLORS = {
    "0" => "white",
    "1" => "blue",
    "2" => "green",
    "3" => "yellow",
    "4" => "magenta",
    "5" => "cyan",
    "6" => "light_green",
    "7" => "light_blue",
    "8" => "light_magenta",
    "B" => "red",
    "+" => "white"
  }

  def initialize
    @symbol = UNCHECKED
    @checked = false
  end

  def to_s
      print "#{symbol} ".send(COLORS[symbol])
  end

  def set_bomb!
    if symbol == UNCHECKED
      @symbol = BOMB
    end
  end

  def bomb?
    symbol == BOMB
  end

  def set_checked!(symbol)
    @checked = true
    @symbol = symbol.to_s
  end

  def checked?
    symbol != UNCHECKED
  end
  
  private

  attr_accessor :symbol, :checked
end
