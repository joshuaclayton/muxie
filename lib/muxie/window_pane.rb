module Muxie
  class WindowPane < BasicDecorator::Decorator
    attr_accessor :root

    def run(&block)
      @component.run(&block)
      self
    end

    def split_commands
      result = []
      result += splits
      result << %{tmux select-pane -t0}
      result
    end

    def run_commands
      indexed_panes.select do |pane|
        pane.has_command?
      end.map do |pane|
        %{tmux send-keys -t#{pane.index} "#{pane.command}" C-m}
      end
    end

    def cd_commands
      indexed_panes.map do |pane|
        %{tmux send-keys -t#{pane.index} "cd #{root}" C-m}
      end
    end

    private

    def splits(base = children, start_index = 0)
      result = []
      direction = base.horizontal? ? " -dh" : ""

      base.split_percentages.each do |dimension|
        result << %{tmux split-window -p#{dimension}#{direction}}
        result << %{tmux select-pane -t#{start_index}}
      end

      base.each_with_index do |pane, index|
        if pane.children.any?
          result << %{tmux select-pane -t#{start_index + index}}
          result += splits(pane.children, start_index + index)
        end
      end

      result
    end
  end
end
