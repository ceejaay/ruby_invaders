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
    @bullets = []
    @text_message = ""
    @invader_phalanx = []
    4.times do |y|
      9.times do |x|
        @invader_phalanx << Invader.new((x * 55) + 100, (y * 55) + 100)
      end
    end
  end

  def update
    @player.right if Gosu::button_down?(Gosu::KbRight) unless @player.collision?(640, 450)
    @player.left if Gosu::button_down?(Gosu::KbLeft) unless @player.collision?(0, 450)
    @bullets.dup.each  do |b| 
      b.move
      if b.out_of_range?
        @bullets.delete(b)
      end
    end
    @invader_phalanx.each {|i| i.move}
    @invader_phalanx.dup.each do |invader|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(invader.x, invader.y, bullet.x, bullet.y)
        if distance < 10
          @bullets.delete(bullet)
          @invader_phalanx.delete(invader)
          end
      end
    end
    close if Gosu::button_down?(Gosu::KbEscape)
  end

  def button_down(id)
    if id == Gosu::KbSpace and @bullets.empty?
     @bullets << Bullet.new(@player.x, @player.y)
    end
  end

  def draw
    @player.draw
    @invader_phalanx.each {|item| item.draw}
    @bullets.each {|b| b.draw}
  end
end

window = SpaceInvader.new
window.show
