module Muxie
  class Pane
    attr_reader :panes, :command, :percent

    def initialize(percent, command)
      @percent = percent
      @command = command
      @panes = []
    end

    def run(&block)
      if block_given?
        instance_exec(&block)
      end
      self
    end

    def has_command?
      @command.present?
    end

    def vpane(percent, command = NullCommand.new, &block)
      @panes << VerticalPane.new(Pane.new(percent, command)).run(&block)
    end

    def hpane(percent, command = NullCommand.new, &block)
      @panes << HorizontalPane.new(Pane.new(percent, command)).run(&block)
    end

    def accept(visitor)
      @panes.each do |pane|
        pane.accept(visitor)
      end
    end
  end
end
