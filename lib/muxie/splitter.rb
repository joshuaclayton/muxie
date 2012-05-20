module Muxie
  class Splitter
    def initialize(percentages)
      @remaining = 100
      @percentages = percentages
    end

    def split
      result = []
      while @percentages.any? && @remaining != 0
        current = @percentages.shift
        result_percent = (current/@remaining.to_f * 100).ceil.to_i
        result << result_percent if result_percent < 100
        @remaining = @remaining - current
      end
      result
    end
  end
end
