module Muxie
  class WindowPane < BasicDecorator::Decorator
    attr_accessor :root

    def run(&block)
      @component.run(&block)
      self
    end

    def split_commands
      []
    end

    def run_commands
      indexed_panes.select do |pane|
        pane.has_command?
      end.map do |pane|
        %{tmux send-keys -t#{pane.index} "#{pane.command}" C-m}
      end
    end

    def indexed_panes
      available_panes.tap do |children|
        children.each_with_index do |child, index|
          child.index = index
        end
      end
    end

    def cd_commands
      indexed_panes.map do |pane|
        %{tmux send-keys -t#{pane.index} "cd #{root}" C-m}
      end
    end

    private

    def available_panes
      all_children.select do |child|
        child.children.none?
      end
    end
  end
end
