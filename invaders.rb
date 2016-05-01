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
    i = 0
    @invader_phalanx = Array.new(11) {Invader.new(i+=60, 150)}
    @text_message = ""
  end

  def update
    @player.right if Gosu::button_down?(Gosu::KbRight) unless @player.collision?(640, 450)
    @player.left if Gosu::button_down?(Gosu::KbLeft) unless @player.collision?(0, 450)

    if @bullet.fire == true
      @bullet.y -= 10
    end

    if @bullet.out_of_range?
      @bullet.fire = false
    end

    @invader_phalanx.each do |alien_ship|
      #this is where all the invader logic goes.
      if alien_ship.collision?(@bullet.x, @bullet.y)
        alien_ship.alive = false
        alien_ship.x, alien_ship.y = -10, -10
        @bullet.fire = false
      end
    end

    close if Gosu::button_down?(Gosu::KbEscape)
  end

  def button_down(id)
    if id == Gosu::KbSpace && @bullet.fire == false
      @bullet.fire = true
      @bullet.x, @bullet.y = @player.x, @player.y
      puts @invader_phalanx.length
    end
  end

  def draw
    @message.draw("#{@text_message}", 10, 30, FONT_COLOR)
    @message.draw("W => 640 - H => 480", 425, 30, FONT_COLOR)
    @player.draw
    @bullet.draw if @bullet.fire == true
    @invader_phalanx.each {|item| item.draw if item.alive == true}
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
  attr_accessor :x, :y, :alive
  def initialize(x, y)
    @x = x
    @y = y
    @sprite = Gosu::Image.new("media/invader.png")
    @alive = true
  end

  def draw
#invader animation will go here.
    @sprite.draw_rot(@x, @y, 1, 0)
  end

  def collision?(barrier_x, barrier_y)
    (@x.between?(barrier_x, barrier_x + 15) and @y.between?(barrier_y, barrier_y + 15)) || ((@x + 25).between?(barrier_x, barrier_x + 15) and (@y + 15).between?(barrier_y, barrier_y + 15))
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
