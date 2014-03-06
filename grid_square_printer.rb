require 'colorize'

class GridSquarePrinter

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

  def to_s(symbol)
    if flag?
      print "#{FLAG} ".send(COLORS[FLAG])
    elsif checked? || flag?
      print "#{symbol} ".send(COLORS[symbol])
    else
      print "#{UNCHECKED} ".send(COLORS[UNCHECKED])
    end
  end
end
