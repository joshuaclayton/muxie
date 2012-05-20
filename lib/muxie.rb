require 'active_support/core_ext'
require 'basic_decorator'

require 'muxie/version'
require 'muxie/dsl'
require 'muxie/window'
require 'muxie/window_pane'
require 'muxie/vertical_pane'
require 'muxie/horizontal_pane'
require 'muxie/pane'
require 'muxie/pane_collection'
require 'muxie/null_command'
require 'muxie/splitter'

module Muxie
  def self.run(&block)
    DSL.new.instance_exec(&block)
  end
end
