require 'gosu'
require './bullet'
require './player'
require './class_invader'
FONT_COLOR = 0xff_ffff00

class SpaceInvader < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Space Invaders"
    @message = Gosu::Font.new(20)
    @player = Player.new
    @bullet_animation = Gosu::Image.new("media/bullet.png")
    @bullet = Bullet.new(@bullet_animation)
    @text_message = ""
    @invader_phalanx = []
    4.times do |y|
      10.times do |x|
        @invader_phalanx << Invader.new((x * 50) + 100, (y * 50) + 100)
      end
    end
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
      alien_ship.move
      if alien_ship.collision?(@bullet.x, @bullet.y)
        alien_ship.alive = false
        #alien_ship.x, alien_ship.y = 250, 600
        @bullet.fire = false
      end
    end
    @invader_phalanx.reject! {|item| item.alive == false}


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

window = SpaceInvader.new
window.show
