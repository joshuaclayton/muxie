module Muxie
  class Window
    attr_reader :commands

    def initialize(name, &block)
      @name = name
      @pane = WindowPane.new(Pane.new(100, NullCommand.new))
      @root = nil
      @block = block
      @commands = []
    end

    def compile
      instance_exec(&@block)
      @commands << "tmux new-window -n #{@name}"

      split_visitor = SplitVisitor.new
      @pane.accept(split_visitor)
      @commands += split_visitor.commands

      cd_visitor = CdVisitor.new(@root)
      @pane.accept(cd_visitor)
      @commands += cd_visitor.commands

      run_command_visitor = RunCommandVisitor.new
      @pane.accept(run_command_visitor)
      @commands += run_command_visitor.commands

      self
    end

    def root(path)
      @root = path
    end

    delegate :vpane, :hpane, to: :@pane
  end
end
