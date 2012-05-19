module Muxie
  class NullPane
    attr_reader :children

    def initialize(*children)
      @children = [children].flatten.compact
    end
  end
end
