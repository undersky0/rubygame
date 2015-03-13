require 'gosu'
  def media_path(file)
    File.join(File.dirname(File.dirname(
       __FILE__)), 'media', file)
  end
class Game < Gosu::Window
  def initialize
    @width = 800
    @height = 600
    super @width,@height,false
    @background = Gosu::Image.new(
      self, media_path('background.png'), false)
    @ball = Gosu::Image.new(
      self, media_path('ball.png'), false)
    @ship = Gosu::Image.new(
      self, media_path('ship.png'), false)
    @alien = Gosu::Image.new(
      self, media_path('alien.png'), false)
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @time = 0
    start_pos
    alien_pos
    @v = 20
    @g = 9.81
    @buttons_down = 0
    @time = 0
    @angle = 20
    @start_time = 0
    @distance = 0
    @radianX = 0
    @viy = 0
    @gameover = false
  end
 
  def update
    @time = (Gosu.milliseconds - @start_time)*0.0001          
    if @trigger
#OPTION 1 - x_impact = (2cos(alpha)sin(alpha)v^2)/g

      # if hit
        # @gameover = true
        # @trigger = false
        # start_pos
        # alien_pos
      # elsif @x < @x_impact
        # @x+= 1
      # else
        # @trigger = false
        # start_pos
        # alien_pos
      # end 
      
#OPTION 2 - projectile equations
      if @x < @distance
        @y -= @viy * @time - 0.5 *@g * (@time**2)
        @x += @v*@time
      elsif hit_bottom
          start_pos
          alien_pos
      elsif hit
        @gameover = true
        @trigger = false
        start_pos
        alien_pos
      else
        @y += @g*(@time**2)
        @x += @v*@time
      end
    end
  end
  
  def draw
    @background.draw(0, 0, 0)    
    @ship.draw_rot(22,580,1,50)
    @alien.draw(@ax,540,0)
    @ball.draw(@x,@y,0)
    @text.draw("Angle: #{@angle}", 500, 10, 1, 1.5, 1.5, Gosu::Color::RED)
    @text.draw("Velocity: #{@v}", 500, 60, 1, 1.5, 1.5, Gosu::Color::RED)
    @text.draw("Up Down - Angle", 300, 300, 1, 1.5, 1.5, Gosu::Color::BLACK) if !@gameover
    @text.draw("  Return - Shoot", 300, 350, 1, 1.5, 1.5, Gosu::Color::BLACK) if !@gameover
    @text.draw("Nice Hit!", 300, 350, 1, 2.5, 1.5, Gosu::Color::BLACK) if @gameover
  end 
  
  def move(angle)
    @gameover = false
    #Option 1 - using the given equation
    @x_impact = ((2*Math.cos(@radianX)*Math.sin(@radianX)*(@v**2))/(@g))+@x
    
    #Option 2 - using the projectile equations
    @radianX = ((3.14/180)*angle)
    @vix = @v*Math.cos(@radianX)#initial velocity x-axis
    @viy = @v*Math.sin(@radianX)#initial velocity y-axis
    @t = (0-@viy)/@g*-1 #time to reach high point
    @h = @viy * @t - 0.5*@g*(@t**2) #high point on y-axis
    @tof = (2*@viy)/@g #time of flight
    @range = ((@v**2)*Math.sin(@radianX*2))/@g #horizontal range  
    @distance = @range/2;
    @distance+=@x #half distance
    @start_time=Gosu.milliseconds    
    @trigger = true
  end
     
  def start_pos
    @trigger = false
    @x = 38
    @y = 558
  end
  
  def alien_pos
    @ax = rand(100...580)
  end
  
  def hit 
    @x > @ax
    #((@x + @ball.width >= @ax) && (@x <= @ax + @alien.width)) && ((@y + @alien.height >= @y) && (@y <= @ay + @alien.height))
  end
   
  def hit_bottom
    @y >= self.height
  end
  
  def button_down(id)
    @angle-=1 if id == Gosu::KbUp
    @angle+=1 if id == Gosu::KbDown
    @v+=1 if id == Gosu::KbLeft
    @v-=1 if id == Gosu::KbRight
    move(@angle) if id == Gosu::KbReturn
    close if id ==Gosu::KbEscape
    @buttons_down += 1
  end
  
  def button_up(id)
    @buttons_down -= 1
  end
end

Game.new.show