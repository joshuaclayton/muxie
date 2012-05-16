module Muxie
  class Visitor
    def initialize
      @commands = []
      @current_index = 0
      @calls = 0
      @current_split = nil
    end

    def commands
      @commands.reject(&:nil?)
    end

    def visit_pane(pane)
    end

    def leave_pane(pane)
    end

    def visit_window_pane(pane)
    end

    def leave_window_pane(pane)
    end

    def visit_horizontal_pane(horizontal_pane)
    end

    def visit_vertical_pane(horizontal_pane)
    end

    private

    def add_command(command)
      @commands << command
    end

    def increment_index
      @current_index += 1
    end

    def increment_calls
      @calls += 1
    end

    def any_calls?
      @calls.nonzero?
    end

    def visit_horizontal
      if vertical?
        @current_split = 'horizontal'
        @calls = 0
      end
    end

    def visit_vertical
      if horizontal?
        @current_split = 'vertical'
        @calls = 0
      end
    end

    def horizontal?
      @current_split == 'horizontal'
    end

    def vertical?
      !horizontal?
    end
  end
end
