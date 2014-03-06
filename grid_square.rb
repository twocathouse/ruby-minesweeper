require 'colorize'

class GridSquare

  UNCHECKED = "+".freeze
  BOMB = "B".freeze
  FLAG = "F".freeze

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
    "+" => "white",
    "F" => "light_red"
  }

  def initialize
    @symbol = UNCHECKED
    @checked = false
  end

  def to_s
    if flag?
      print "#{FLAG} ".send(COLORS[FLAG])
    elsif checked? || flag?
      print "#{symbol} ".send(COLORS[symbol])
    else
      print "#{UNCHECKED} ".send(COLORS[UNCHECKED])
    end
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
    if !bomb?
      @symbol = symbol.to_s
    end
  end

  def checked?
    checked
  end

  def set_checked
    @checked = true
  end

  def flag
    if !checked?
      @flagged = true
    end
  end

  def unflag
    if flag?
      @flagged = false
    end
  end

  def flag?
    flagged
  end
  private

  attr_accessor :symbol, :checked, :flagged
end
