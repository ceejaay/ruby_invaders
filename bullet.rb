class Bullet
  attr_accessor :x, :y, :fire
  def initialize(animation)
    @x = 0
    @y = 480
    @animation = animation
    @fire = false
  end

  def draw
#bullet animation will go here
    @animation.draw_rot(@x, @y, 1, 0)
  end

  def out_of_range?
    @y <= 0
  end
end
