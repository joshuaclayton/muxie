module Muxie
  class CdVisitor < Visitor
    def initialize(path)
      super()
      @path = path
    end

    def visit_horizontal_pane(pane)
      visit_horizontal
      if any_calls?
        increment_index
      end
      increment_calls
    end

    def visit_vertical_pane(pane)
      visit_vertical
      if any_calls?
        increment_index
      end
      increment_calls
    end

    def leave_window_pane(pane)
      (0..@current_index).each do |index|
        add_command %{tmux send-keys -t #{index} "cd #{@path}" C-m}
      end
    end
  end
end
