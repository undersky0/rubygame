# There is a player with a spaceship at position 0 along an axis, and there is an alien at some 
# unknown initial position x_0 on that axis. The player and the (computer-controlled) alien take 
# turns. The player tries to hit the alien. In each player turn the player can set the firing angle 
# alpha of the spaceship and then fire it. The ball velocity v of the spaceship is fixed. The 
# spaceship ball hits the ground at this distance x_impact from the spaceship: x_impact = 
# (2cos(alpha)sin(alpha)v^2)/g where g = 9.81 m/s^2 is the earth's gravitational acceleration. 
# In each alien turn the alien moves one step (of some fixed size m) to the right or to the left 
# with equal probability. The game goes on until the spaceship ball hits the ground within a 
# distance d of the alien's current position. Write a game that lets the user play until he hits the 
# alien. You can pick values for the fixed parameters in this problem.

require 'gosu'
  def media_path(file)
    File.join(File.dirname(File.dirname(
       __FILE__)), 'media', file)
  end
  
class Ball
  def initialize(win)
    @x = 38
    @y = 558
    @g = -9.8
    @v = 100
    @image = Gosu::Image.new(
      win, media_path('ball.png'), false)
  end
  
  def draw
    @image.draw_rot(@x,@y,0,0)
  end
  def move
    @x += Gosu.milliseconds * 0.00001
  end
end  
  
class Game < Gosu::Window
  
  BACKGROUND = media_path('background.png')
  SHIP = media_path('ship.png')
  ALIEN = media_path('alien.png')
  
  def initialize(width=800, height=600, fullscreen=false)
    super
    self.caption = 'Hello Movement'
    @background = Gosu::Image.new(
      self, BACKGROUND, false)
    @ship = Gosu::Image.new(
      self, SHIP, false)
    @alien = Gosu::Image.new(
      self, ALIEN, false)
    @ball = Ball.new(self)
    @x = @y = 10
    @angle = 45
    @draws = 0
    @buttons_down = 0
    @time3 = Gosu.milliseconds
    @z=300
  end
  
  def update
    @angle -= 1 if button_down?(Gosu::KbLeft)
    @angle += 1 if button_down?(Gosu::KbRight)
    @time3 = Gosu.milliseconds
    if @angle == 0 || @angle == 100
      @angle = 45
    end
    @ball.move
    @z +=1
  end
  
  # def track_update_interval
    # now = Gosu.milliseconds
    # @update_interval = (now - (@last_update ||= 0)).to_f
    # @last_update = now
  # end
  def update_interval
    @update_interval ||= $window.update_interval
  end
  
  
  
  def needs_redraw?
    @draws == 0 || @buttons_down > 0
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    # shoot if id == Gosu::KbReturn
    @buttons_down += 1
  end
  
  # def shoot
    # @bx +=1
    # vi = @v*@g
   # # t = (Gosu.milliseconds - @time)* 0.001
    # @xs = (2*Math.cos(@angle)*Math.sin(@angle)*@v*2)/@g
#     
    # @time2 = 0
    # vix = @v*Math.cos(@angle)#initial velocity x-axis
    # viy = @v*Math.cos(@angle)#initial velocity y-axis
#     
    # t = (0-viy)/@g #time to reach high point
    # t2 = (-2 * viy)/@g
    # disy = viy * t + 0.5*@g*((t)*(t)) #high point on y-axis
    # disx = @v*t2*(Math.cos(@angle)) #displacement on x-axis
    # disyd = 0.5 * @g * ((t2-t) * (t2 - t)) #displacement y downpoints
#     
    # lasttime2 = Gosu.milliseconds
#     
  # end
#   
  # def x_displacement
    # t = (Gosu.milliseconds - @time)* 0.001
    # vix = @v*Math.cos(@angle)#initial velocity x-axis
  # end
#   
  # def y_displacement
    # viy = @v*Math.cos(@angle)#initial velocity y-axis
  # end
  
  def button_up(id)
    @buttons_down -= 1
  end
  
  def draw
    # x-800,y-600,z-0
    @draws += 1
    @background.draw(0, 0, 0)    
    @ship.draw_rot(22,580,1,@angle)
    @alien.draw(@z,540,0)
    @ball.draw
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @text.draw(info, 450, 10, 1, 1.5, 1.5, Gosu::Color::RED)
  end
  
   def info
     "x: #{@time3}, Angle: #{@angle}"
   end
end

Game.new.show