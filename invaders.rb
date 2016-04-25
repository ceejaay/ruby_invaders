require 'gosu'


FONT_COLOR = 0xff_ffff00

class SpaceInvader < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Space Invaders"
  end


  def update
  end

  def draw
  end

  def button_down(id)
  end

end


window = SpaceInvader.new
window.show
