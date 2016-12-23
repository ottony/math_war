class Bullet
  include Debug

  attr_accessor :x, :y
  attr_reader :tick, :exploding

  COLOR  = 0xff_FF0000

  def initialize(window, x, y, width = 10, heigth = 10)
    @window, @x, @y = window, x.to_f, y.to_f
    @trajectory = Trajectory.new( x: @x, y: @y )
    @tick = 0
  end

  def trajectory(x: , y: )
    @trajectory.x = x
    @trajectory.y = y
    @tick = 0
  end

  def update
    @x = @trajectory.x(tick)
    @y = @trajectory.y(tick)

    @tick += 1
  end

  def wall_colision?
    x > @window.width  or x < 0 or
    y > @window.height or y < 0
  end

  def draw
    if exploding?
      d("EXPLODING")
      stop if tick >= 100
    else
      @window.draw_quad(x     , y     , COLOR ,
                        x + 9 , y     , COLOR ,
                        x     , y + 9 , COLOR ,
                        x + 9 , y + 9 , COLOR , 1)
    end
  end

  def exploding?
    !! exploding
  end

  def explode!
    return if exploding?
    stop
    @exploding = true
  end

  private

  def stop
    @exploding = false
    @tick = 0
    @trajectory.stop
  end
end
