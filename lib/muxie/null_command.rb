module Muxie
  class NullCommand < BasicObject
    def to_s; ''; end
    def nil?; true; end
    def present?; !nil?; end
  end
end
