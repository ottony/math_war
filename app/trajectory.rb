class Trajectory
  include Math
  include Debug

  attr_reader :initial_x, :initial_y, :last_time

  def initialize x: 0, y: 0
    @initial_x, @initial_y = x, y
  end

  def x=(input_text)
    input_text = 't'  if input_text.to_s.empty?
    def_movement(:x, input_text)
  end

  def y=(input_text)
    input_text = initial_y  if input_text.to_s.empty?
    def_movement(:y, input_text)
  end

  def x(time = 0)
    initial_x
  end

  def y(time = 0)
    initial_y
  end

  def stop
    @initial_x = x(0)
    @initial_y = y(0)

    def_movement(:x, 0)
    def_movement(:y, 0)
  end

  private

  def def_movement(cordinate, function)
    initial_ = "@initial_#{ cordinate }"

    #  @initial_x = x(@last_time)
    #
    #  def x(t)
    #    t = t.to_f
    #    @initial_x ||= 0
    #    @initial_x += sin(t)
    #  end

    instance_eval <<-METHOD
      #{ initial_ } = #{ cordinate }(@last_time)
      d("#{ initial_ }: \#\{#{ initial_ }\}")

      def #{ cordinate }(t)
        t = t.to_f
        @last_time = t
        (#{ function }) + (#{ initial_ } || 0.0)
      end
    METHOD
  end
end
