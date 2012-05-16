module Muxie
  class VerticalPane < BasicDecorator::Decorator
    def accept(visitor)
      visitor.visit_vertical_pane(self)
      @component.accept(visitor)
    end

    def run(&block)
      @component.run(&block)
      self
    end
  end
end
