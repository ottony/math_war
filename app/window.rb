class Window < Gosu::Window
  def initialize
    super(500, 400, false)

    @font        = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @text_fields = [ TextInput.new(self, @font, 0, 0), TextInput.new(self, @font, 0, @font.height + 2) ]

    @bullet = Bullet.new(self, self.width / 2, self.height / 2)
    @cursor = Gosu::Image.new(self, "media/cursor.png", false)
    @frame  = 0
  end

  def update
    @bullet.update

    @frame += 1
  end

  def actions
    @actions ||= {
      Gosu::KbTab    => lambda{ next_input },
      Gosu::KbF5     => lambda{ reload },
      Gosu::KbEscape => lambda{ unfocus_input },
      Gosu::KbDelete => lambda{ exit },
      Gosu::MsLeft   => lambda{ mouse_click },
      Gosu::KbReturn => lambda{ change_trajectory }
    }
  end

  def button_down id
    actions[id].call if actions[id]
  end

  def draw
    @text_fields.each(&:draw)
    @bullet.draw

    @cursor.draw(mouse_x, mouse_y, 2)
    @font.draw("#{Gosu.fps} fps. Frame #{@frame}", 10, self.height - @font.height, 0)
    @font.draw("X: #{ @bullet.x } Y: #{ @bullet.y }", 10, self.height - @font.height - 10, 0)
  end

  private

  def next_input
    index = @text_fields.index(self.text_input) || -1
    self.text_input = @text_fields[(index + 1) % @text_fields.size]
  end

  def unfocus_input
    self.text_input = nil if self.text_input
  end

  def mouse_click
    self.text_input = @text_fields.find { |tf| tf.under_point?(mouse_x, mouse_y) }
  end

  def change_trajectory
    @bullet.trajectory x: @text_fields[1].text, y: @text_fields[0].text
  end

  def reload
    close
  end
end
