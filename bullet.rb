class Bullet
  attr_accessor :x, :y

  COLOR  = 0xff_FF0000

  def initialize window, x, y
    @window, @x, @y = window, x.to_f, y.to_f
    @trajectory = Trajectory.new( x: @x, y: @y )
    @time = 0
  end

  def trajectory x: , y:
    @trajectory.x = x
    @trajectory.y = y
    @time = 0
  end

  def update
    @x = @trajectory.x( @time )
    @y = @trajectory.y( @time )

    @time = @time + 1
  end

  def draw
    @window.draw_quad(ball_x     , ball_y     , COLOR ,
                      ball_x + 9 , ball_y     , COLOR ,
                      ball_x     , ball_y + 9 , COLOR ,
                      ball_x + 9 , ball_y + 9 , COLOR , 1)
  end

  private

  def ball_x
    @x - 5
  end

  def ball_y
    @y - 5
  end
end
