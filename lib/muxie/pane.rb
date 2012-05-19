module Muxie
  class Pane
    attr_accessor :index
    attr_reader :panes, :command, :percent, :parent

    def initialize(percent, command, parent = nil)
      @percent = percent
      @command = command
      @parent = parent || NullPane.new(self)
      @panes = []
    end

    def run(&block)
      if block_given?
        instance_exec(&block)
      end
      self
    end

    def children
      @panes
    end

    def all_children
      children.map do |child|
        [child] + child.all_children
      end.flatten
    end

    def inspect
      "#<Muxie::Pane index: #{@index}, percent: #{@percent}, command: '#{@command}'>"
    end

    def to_s
      inspect
    end

    def siblings
      parent.children - [self]
    end

    def has_command?
      !@command.empty?
    end

    def vpane(percent, command = NullCommand.new, &block)
      @panes << VerticalPane.new(Pane.new(percent, command, self)).run(&block)
    end

    def hpane(percent, command = NullCommand.new, &block)
      @panes << HorizontalPane.new(Pane.new(percent, command, self)).run(&block)
    end
  end
end
