module Muxie
  class NullCommand < BasicObject
    def to_s; ''; end
    def nil?; true; end
    def empty?; true; end
    def inspect; to_s; end
  end
end
