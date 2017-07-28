class Invader
  attr_accessor :x, :y, :alive
  def initialize(x, y)
    @x = x
    @y = y
    @sprite = Gosu::Image.new("media/invader.png")
    @alive = true
    @right_side = @x + 50
    @left_side = @x - 50
    @move_left = true
  end

  def draw
#invader animation will go here.
    @sprite.draw_rot(@x, @y, 1, 0)
  end

#this collision method is different than the player one. This is the one I wrote myself
  def collision?(barrier_x, barrier_y)
       (barrier_x.between?(@x - 10, @x) and barrier_y.between?(@y, @y + 10)) || (barrier_x.between?(@x, @x + 10) && barrier_y.between?(@y - 10, @y)) || (barrier_x.between?(@x - 10, @x) &&  barrier_y.between?(@y - 10, @y)) || (barrier_x.between?(@x, @x + 10) && barrier_y.between?(@y, @y + 10))
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
