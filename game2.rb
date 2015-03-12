require 'gosu'
  def media_path(file)
    File.join(File.dirname(File.dirname(
       __FILE__)), 'media', file)
  end
class Game < Gosu::Window
  BACKGROUND = media_path('background.png')
  SHIP = media_path('ship.png')
  ALIEN = media_path('alien.png')
  
  def initialize
    @width = 800
    @height = 600
    super @width,@height,false
    @ball = Ball.new(self)
    @background = Gosu::Image.new(
      self, BACKGROUND, false)
    @ship = Gosu::Image.new(
      self, SHIP, false)
    @alien = Gosu::Image.new(
      self, ALIEN, false)
    @angle = 45
    @buttons_down = 0
    @time = 0
  end
  
  def update
    @angle -= 1 if button_down?(Gosu::KbLeft)
    @angle += 1 if button_down?(Gosu::KbRight)
    @time+=1
  end
  
  def draw
    @background.draw(0, 0, 0)    
    @ship.draw_rot(22,580,1,@angle)
    @alien.draw(300,540,0)
    @ball.draw
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @text.draw(@time, 450, 10, 1, 1.5, 1.5, Gosu::Color::RED)
  end
  
  def hit_bottom
    @y >= self.height
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    @ball.move(@angle) if id == Gosu::KbReturn
    @buttons_down += 1
  end
  
  def button_up(id)
    @buttons_down -= 1
  end
  
  def info
    "Angle: #{time_elapsed} : #{@time}"
  end
  def time_elapsed
    @time = Gosu.milliseconds/100
  end
  
end
Game.new.show