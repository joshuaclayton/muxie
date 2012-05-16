module Muxie
  class Window
    attr_reader :commands
    delegate :vpane, :hpane, to: :@pane

    def initialize(name, &block)
      @name = name
      @pane = WindowPane.new(Pane.new(100, NullCommand.new))
      @root = nil
      @block = block
      @commands = []
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
    end

    private

    def generate_command_for_new_window
      @commands << "tmux new-window -n #{@name}"
    end

    def generate_commands_for_splits
      SplitVisitor.new.tap do |split_visitor|
        @pane.accept(split_visitor)
        @commands += split_visitor.commands
      end
    end

    def generate_commands_for_cd
      CdVisitor.new(@root).tap do |cd_visitor|
        @pane.accept(cd_visitor)
        @commands += cd_visitor.commands
      end
    end

    def generate_commands_for_panes
      RunCommandVisitor.new.tap do |run_command_visitor|
        @pane.accept(run_command_visitor)
        @commands += run_command_visitor.commands
      end
    end
  end
end
