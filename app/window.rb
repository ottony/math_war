class Window < Gosu::Window
  attr_reader :font, :text_fields, :bullet, :cursor, :frame

  def initialize
    super(500, 400, false)

    @font        = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @text_fields = [
      TextInput.new(self, font, 0, 0, '100*sin(t/100)'),
      TextInput.new(self, font, 0, font.height + 2, 't/5')
    ]

    @bullet = Bullet.new(self, self.width / 2, self.height / 2)
    @cursor = Gosu::Image.new(self, "media/cursor.png", false)
    @frame  = 0
  end

  def update
    if bullet.wall_colision? || bullet.any_collision?
      bullet.explode!
    end

    bullet.update

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
    }.freeze
  end

  def button_down(key)
    actions[key].call if actions[key]
  end

  def draw
    text_fields.each(&:draw)
    bullet.draw

    cursor.draw(mouse_x, mouse_y, 2)
    font.draw("#{Gosu.fps} fps. Frame #{frame}", 10, self.height - font.height, 0)
    font.draw("X: #{ bullet.x } Y: #{ bullet.y }", 10, self.height - font.height - 15, 0)
    font.draw('Exploding', 10, self.height - font.height - 30, 0) if bullet.exploding
  end

  private

  def next_input
    index = text_fields.index(self.text_input) || -1
    self.text_input = text_fields[(index + 1) % text_fields.size]
  end

  def unfocus_input
    self.text_input = nil
  end

  def mouse_click
    self.text_input = text_fields.find { |tf| tf.under_point?(mouse_x, mouse_y) }
  end

  def change_trajectory
    i_y, i_x = text_fields
    bullet.trajectory(x: i_x.text, y: i_y.text)
  end

  def reload
    close
  end
end
