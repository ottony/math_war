class Trajectory
  include Math

  attr_reader :last_x, :last_y

  def initialize x: 0, y: 0
    @last_x, @last_y = x, y
  end

  def x= input_text
    input_text = 't'  if input_text.to_s.empty?
    new_function :x, input_text
  end

  def y= input_text
    input_text = @last_y  if input_text.to_s.empty?
    new_function :y, input_text
  end

  def x time
    @last_x
  end

  def y time
    @last_y
  end

  private

  def new_function cordinate, content
    cordinate_const   = "@last_#{ cordinate }"
    cordinate_value   = instance_variable_get cordinate_const if instance_variable_defined? cordinate_const
    cordinate_value ||= 0

    function = "#{ cordinate_const } = ( #{ content } ) + #{ cordinate_value }"

    puts function

    instance_eval <<-METHOD
      def #{ cordinate }(t)
        t = t.to_f
        #{ function }
      end
    METHOD
  end
end
