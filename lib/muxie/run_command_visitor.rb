module Muxie
  class RunCommandVisitor < Visitor
    def visit_horizontal_pane(pane)
      visit_horizontal

      if any_calls?
        increment_index
      end

      if pane.has_command?
        add_command %{tmux send-keys -t #{current_index} "#{pane.command}" C-m}
      end

      increment_calls
    end

    def visit_vertical_pane(pane)
      visit_vertical

      if any_calls?
        increment_index
      end

      if pane.has_command?
        add_command %{tmux send-keys -t #{current_index} "#{pane.command}" C-m}
      end

      increment_calls
    end
  end
end
