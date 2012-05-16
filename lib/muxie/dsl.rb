module Muxie
  class DSL
    def window(name, &block)
      Window.new(name, &block).compile
    end
  end
end
