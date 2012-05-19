module Muxie
  class VerticalPane < BasicDecorator::Decorator
    def run(&block)
      @component.run(&block)
      self
    end

    def vpane(*args)
      raise ArgumentError, "cannot nest vertical pane within another vertical pane"
    end

    def horizontal?
      false
    end

    def vertical?
      true
    end
  end
end
