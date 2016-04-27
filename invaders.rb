require 'gosu'
FONT_COLOR = 0xff_ffff00

class SpaceInvader < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Space Invaders"
    @message = Gosu::Font.new(20)
    @player = Player.new
    @bullet_animation = Gosu::Image.new("media/bullet.png")
    @invader_phalanx = Array.new
    11.times {@invader_phalanx << Invader.new}
    @bullets = Array.new
  end

  def update
    @bullets.each do |item|
      item.y -= 3
    end
    @bullets.reject! {|bullet| bullet.y == 0}
    @player.right if Gosu::button_down?(Gosu::KbRight) unless @player.collision?(640, 450)
    @player.left if Gosu::button_down?(Gosu::KbLeft) unless @player.collision?(0, 450)
    close if Gosu::button_down?(Gosu::KbEscape)
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push(Bullet.new(@player.x, @player.y, @bullet_animation)) unless @bullets.length == 1
    end
  end

  def draw
    @message.draw("Player X => #{@player.x} - Player Y => #{@player.y}", 10, 30, FONT_COLOR)
    @message.draw("W => 640 - H => 480", 425, 30, FONT_COLOR)
    #@message.draw("Distance from 0 => #{Gosu::distance(@player.x, @player.y, 320, 0)}", 10, 60, FONT_COLOR)
    @player.draw
    @bullets.each {|item| item.draw}
    @invader_phalanx.each_with_index do |value, index|
      value.draw((index * 58.2), 150)
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
    @sprite = Gosu::Image.new("media/invader.png")
  end

  def draw(x, y)
    @sprite.draw_rot(x, y, 1, 0)
  end

  def invader_move
    if @x >= 50
      @x = 25
      @x += 5
      end
  end
end

class Bullet
  attr_accessor :x, :y
  def initialize(x, y, animation)
    @x = x
    @y = y
    @animation = animation
  end

  def draw
    @animation.draw_rot(@x, @y, 1, 0)
  end

  def collision?(barrier_x, barrier_y)
    (@x.between?(barrier_x, barrier_x + 30) and @y.between?(barrier_y, barrier_y + 30)) || ((@x + 30).between?(barrier_x, barrier_x +30) and (@y + 30).between?(barrier_y, barrier_y + 30))
  end
end

window = SpaceInvader.new
window.show
