module Muxie
  class HorizontalPane < BasicDecorator::Decorator
    def accept(visitor)
      visitor.visit_horizontal_pane(self)
      @component.accept(visitor)
    end

    def run(&block)
      @component.run(&block)
      self
    end
  end
end

