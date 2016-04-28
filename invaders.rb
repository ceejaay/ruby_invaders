require 'gosu'
FONT_COLOR = 0xff_ffff00

class SpaceInvader < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Space Invaders"
    @message = Gosu::Font.new(20)
    @player = Player.new
    @bullet_animation = Gosu::Image.new("media/bullet.png")
    @bullet = Bullet.new(@bullet_animation)
    @invader_phalanx = Array.new(11) {Invader.new}
    @text_message = ""
  end

  def update
    @player.right if Gosu::button_down?(Gosu::KbRight) unless @player.collision?(640, 450)
    @player.left if Gosu::button_down?(Gosu::KbLeft) unless @player.collision?(0, 450)
    if @bullet.fire == true
      @bullet.y -= 7
    end
    if @bullet.out_of_range?
      @bullet.fire = false
    end
    if @bullet.x.between?(300, 400)
      @text_message = "In the ZONE" 
     else 
       @text_message = "NO WAY"
    end
    close if Gosu::button_down?(Gosu::KbEscape)
  end

  def button_down(id)
    if id == Gosu::KbSpace && @bullet.fire == false
      @bullet.fire = true
      @bullet.x, @bullet.y = @player.x, @player.y
    end
  end

  def draw
    @message.draw("#{@text_message}", 10, 30, FONT_COLOR)
    @message.draw("W => 640 - H => 480", 425, 30, FONT_COLOR)
    #@message.draw("Distance from 0 => #{Gosu::distance(@player.x, @player.y, 320, 0)}", 10, 60, FONT_COLOR)

    @player.draw
    @bullet.draw if @bullet.fire == true
    @invader_phalanx.each_with_index do |value, index|
      value.draw((index * 60.2), 150)
    end
  end
end

class Player
  attr_accessor :x, :y, :ammo
  def initialize
    @x = 320
    @y = 450
    @sprite = Gosu::Image.new("media/icon.png")
  end

  def draw
    @sprite.draw_rot(@x, @y, 1, 0)
  end

  def left
    @x -= 7
  end

  def right
    @x += 7
  end

  def collision?(barrier_x, barrier_y)
    (@x.between?(barrier_x, barrier_x + 30) and @y.between?(barrier_y, barrier_y + 30)) || ((@x + 30).between?(barrier_x, barrier_x +30) and (@y + 30).between?(barrier_y, barrier_y + 30))
  end
end

class Invader
  attr_accessor :x, :y
  def initialize
    @x = 26
    @y = 150
    @sprite = Gosu::Image.new("media/invader.bmp")
  end

  def draw(x, y)
#invader animation will go here.
    @sprite.draw_rot(x, y, 1, 0)
  end

  def collision?(barrier_x, barrier_y)
    (@x.between?(barrier_x, barrier_x + 30) and @y.between?(barrier_y, barrier_y + 30)) || ((@x + 30).between?(barrier_x, barrier_x +30) and (@y + 30).between?(barrier_y, barrier_y + 30))
  end

end

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

window = SpaceInvader.new
window.show
