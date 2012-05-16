module Muxie
  class SplitVisitor < Visitor
    def visit_horizontal_pane(pane)
      visit_horizontal
      if any_calls?
        add_command "tmux split-window -p#{pane.percent} -t#{@current_index} -dh"
        increment_index
      end
      increment_calls
    end

    def visit_vertical_pane(pane)
      visit_vertical
      if any_calls?
        add_command "tmux split-window -p#{pane.percent} -t#{@current_index}"
        increment_index
      end
      increment_calls
    end
  end
end
