module Muxie
  class HorizontalPane < BasicDecorator::Decorator
    def run(&block)
      @component.run(&block)
      self
    end

    def horizontal?
      true
    end
  end
end
