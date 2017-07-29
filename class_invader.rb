class Invader
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
    @sprite = Gosu::Image.new("media/invader.png")
    @right_side = @x + 50
    @left_side = @x - 50
    @move_left = true
  end

  def draw
#invader animation will go here.
    @sprite.draw_rot(@x, @y, 1, 0)
  end

  def move
    if @move_left == true and @x > @left_side
        @x -= 1
    else
       @move_left = false
      end
    if @move_left == false and @x < @right_side
      @x += 1
    else
       @move_left = true
    end
    #puts  Gosu::distance(@x, @y, 55, @y)
  end
end
