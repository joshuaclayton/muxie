module Muxie
  class Pane
    attr_accessor :index
    attr_reader :children, :command, :percent
    delegate :all_children, :indexed_panes, :split_percentages, :panes_with_commands, to: :@children

    def initialize(percent, command)
      @percent = percent
      @command = command
      @children = PaneCollection.new
    end

    def run(&block)
      if block_given?
        instance_exec(&block)
      end
      self
    end

    def has_command?
      !@command.empty?
    end

    def vpane(percent, command = NullCommand.new, &block)
      @children << VerticalPane.new(Pane.new(percent, command)).run(&block)
    end

    def hpane(percent, command = NullCommand.new, &block)
      @children << HorizontalPane.new(Pane.new(percent, command)).run(&block)
    end
  end
end
