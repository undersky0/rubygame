require 'gosu'
  def media_path(file)
    File.join(File.dirname(File.dirname(
       __FILE__)), 'media', file)
  end
  
class Ball
  def initialize(win)
    @x = 3 
    @y = 558
    @g = -9.8
    @v = 100
    @image = Gosu::Image.new(
      win, media_path('ball.png'), false)
    @text = Gosu::Font.new(win, Gosu::default_font_name, 20)
  end
  
  def update
    @time +=100
  end
  
  def draw
    @image.draw_rot(@x,@y,0,0)
    @text.draw(@time, 450, 100, 1, 1.5, 1.5, Gosu::Color::RED)
  end
  def move(angle)
    @time = 1
    time2 = 0
    radianX = ((3.14/180)*angle)
    vix = @v*Math.cos(angle)#initial velocity x-axis
    viy = @v*Math.sin(angle)#initial velocity y-axis
    t = (0-viy)/@g #time to reach high point
    t2 = (-2 * viy)/@g
    disy = viy * t + 0.5*@g*((t)*(t)) #high point on y-axis
    disx = @v*t2*(Math.cos(angle)) #displacement on x-axis
    disyd = 0.5 * @g * ((t2-t) * (t2 - t)) #displacement y downpoints
    
    current_time = Gosu.milliseconds
    last_time = Gosu.milliseconds
    interval = (current_time - last_time)/100
    
    distance = disx/2;

    # if @time > 2
      # print "time2: #{@time}"
    # end
    # while @x < distance
      # @x -= @v*interval *(Math.cos(radianX))
      # @y += viy * interval + 0.5*@g*((interval)*(interval))
    # end
    
  end
end  