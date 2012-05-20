module Muxie
  class PaneCollection
    include Enumerable

    delegate :<<, to: :@panes
    delegate :horizontal?, to: :first_pane

    def initialize(panes = [])
      @panes = panes
    end

    def each(&block)
      @panes.each(&block)
    end

    def split_percentages
      percentages = map(&:percent)

      if percentages.length == 2
        percentages.shift
      end

      Splitter.new(percentages).split
    end

    def all_children
      map do |child|
        [child] + child.all_children
      end.flatten
    end

    def panes_with_commands
      indexed_panes.select(&:has_command?)
    end

    def indexed_panes
      without_children.tap do |children|
        children.each_with_index do |child, index|
          child.index = index
        end
      end
    end

    private

    def first_pane
      @panes.first
    end

    def without_children
      all_children.select do |child|
        child.children.none?
      end
    end
  end
end
