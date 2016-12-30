class Bullet
  include Debug

  attr_accessor :x, :y, :angle
  attr_reader :tick, :exploding, :ball

  COLOR = 0xff_FF0000
  SCALE = 0.1

  def initialize(window, x, y)
    @window, @x, @y, @angle = window, x.to_f, y.to_f, 0
    @trajectory = Trajectory.new( x: @x, y: @y )
    @tick = 0
  end

  def ball
    @ball ||= Gosu::Image.load_tiles(@window, 'media/ball.png', 512, 512, true)
  end

  def trajectory(x: , y: )
    @trajectory.x = x
    @trajectory.y = y
    @tick = 0
  end

  def update
    @x, @y, @angle = @trajectory.position(tick)

    @tick += 1
  end

  def wall_colision?
    x > @window.width  or x < 0 or
    y > @window.height or y < 0
  end

  def any_collision?(squares = [])
  end

  def draw
    if exploding?
      d("EXPLODING")
      stop if tick >= 100
    else
      ball[ ( tick / 5 ) % ball.count].draw_rot(
        x, y, 2,
        angle,
        0.5, 0.5,
        SCALE, SCALE
      )
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
