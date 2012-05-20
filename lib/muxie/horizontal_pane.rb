module Muxie
  class HorizontalPane < BasicDecorator::Decorator
    def run(&block)
      @component.run(&block)
      self
    end

    def hpane(*args)
      raise ArgumentError, "cannot nest horizontal pane within another horizontal pane"
    end

    def horizontal?
      true
    end
  end
end
