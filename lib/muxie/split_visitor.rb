module Muxie
  class SplitVisitor < Visitor
    def visit_horizontal_pane(pane)
      if vertical?
        add_command "tmux select-pane -t#{current_index}"
      end

      visit_horizontal
      if any_calls?
        add_command "tmux split-window -p#{pane.percent} -dh"
        increment_index
      end
      increment_calls
    end

    def visit_vertical_pane(pane)
      if horizontal?
        add_command "tmux select-pane -t#{current_index}"
      end

      visit_vertical
      if any_calls?
        add_command "tmux split-window -p#{pane.percent}"
        increment_index
      end
      increment_calls
    end

    def leave_window_pane(pane)
      add_command "tmux select-pane -t0"
    end
  end
end
