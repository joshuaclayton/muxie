module Muxie
  class Window
    attr_reader :commands
    delegate :vpane, :hpane, to: :pane

    def initialize(name, &block)
      @name = name
      @block = block
      reset
    end

    def compile
      instance_exec(&@block)

      generate_command_for_new_window
      generate_commands_for_splits
      generate_commands_for_cd
      generate_commands_for_panes

      self
    end

    def root(path)
      @root = path
      pane.root = @root
    end

    def pane
      @pane ||= WindowPane.new(Pane.new(100, NullCommand.new))
    end

    private

    def generate_command_for_new_window
      @commands << "tmux new-window -n #{@name}"
    end

    def generate_commands_for_splits
      @commands += pane.split_commands
    end

    def generate_commands_for_cd
      @commands += pane.cd_commands
    end

    def generate_commands_for_panes
      @commands += pane.run_commands
    end

    def reset
      @pane = nil
      @root = nil
      @commands = []
    end
  end
end
