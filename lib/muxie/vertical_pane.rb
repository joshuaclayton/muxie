module Muxie
  class VerticalPane < BasicDecorator::Decorator
    def run(&block)
      @component.run(&block)
      self
    end

    def horizontal?
      false
    end
  end
end
