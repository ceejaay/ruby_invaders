require 'gosu'


FONT_COLOR = 0xff_ffff00

class SpaceInvader < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Space Invaders"
    @message = Gosu::Font.new(20)
    @player = Player.new
  end


  def update
    @player.right if Gosu::button_down?(Gosu::KbRight) unless @player.collision?(640, 450)
    @player.left if Gosu::button_down?(Gosu::KbLeft) unless @player.collision?(0, 450)
    close if Gosu::button_down?(Gosu::KbEscape)
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @player.ammo[0].update(@player.x, @player.y)
      #bullet firing code goes here.
    end
  end

  def draw
    @message.draw("Player X => #{@player.x} - Player Y => #{@player.y}", 10, 30, FONT_COLOR)
    @message.draw("Distance from 0 => #{Gosu::distance(@player.x, @player.y, 320, 0)}", 10, 60, FONT_COLOR)
    @player.draw
    @player.ammo[0].draw
    #@player.ammo.each {|item| draw.item}
  end


end

class Player
  attr_accessor :x, :y, :ammo
  def initialize
    @x = 320
    @y = 450
    @ammo = Array.new(5) {Bullet.new}
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

  def fire_bullet
  end

  def collision?(barrier_x, barrier_y)
    #calculate distanct between cordinates and barrier coordinates.
    (@x.between?(barrier_x, barrier_x + 30) and @y.between?(barrier_y, barrier_y + 30)) || ((@x + 30).between?(barrier_x, barrier_x +30) and (@y + 30).between?(barrier_y, barrier_y + 30))
  end
end

class Bullet
  attr_accessor :x, :y, :firing
  def initialize
    @x = 0
    @y = 0
    @bullet = Gosu::Font.new(20)
  end


  def draw
    @bullet.draw("i", @x, @y, FONT_COLOR)
  end

  def update(player_x, player_y)
    @x = player_x
    @y = player_y
  end


  def collision?(barrier_x, barrier_y)
    #calculate distanct between cordinates and barrier coordinates.
    (@x.between?(barrier_x, barrier_x + 30) and @y.between?(barrier_y, barrier_y + 30)) || ((@x + 30).between?(barrier_x, barrier_x +30) and (@y + 30).between?(barrier_y, barrier_y + 30))
  end
end

window = SpaceInvader.new
window.show
