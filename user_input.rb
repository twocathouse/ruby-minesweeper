class UserInput

  FLAG = "f"

  def initialize
    @flag = false
    @position = []
  end

  attr_reader :position

  def gets
    print "Move? "
    input = gets.strip.split " "
    store input
    self
  end

  def flag?
    flag
  end

  private
  attr_accessor :flag

  def store(input)
    check_flag input
    get_position input
  end

  def check_flag
    if input[0] == FLAG
      @flag = true
    end
  end

  def get_position
    position = input.select { |element| element.to_i > 0 }
    position.map! { |element| element.to_i }
    @position = { row: position[0], column: position[1] }
  end

end
