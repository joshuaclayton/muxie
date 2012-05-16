module Muxie
  class WindowPane < BasicDecorator::Decorator
    def accept(visitor)
      visitor.visit_window_pane(self)
      @component.accept(visitor)
      visitor.leave_window_pane(self)
    end

    def run(&block)
      @component.run(&block)
      self
    end
  end
end
