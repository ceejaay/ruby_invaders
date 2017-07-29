class Bullet
  attr_accessor :x, :y, :fire, :radius
  def initialize(x, y)
    @x = x
    @y = y
    @animation = Gosu::Image.new("media/bullet.png")
    @radius = 5
  end

  def draw
    @animation.draw_rot(@x, @y, 1, 0)
  end

  def move
    @y -= 5
  end

  def out_of_range?
    @y <= 0
  end
end
