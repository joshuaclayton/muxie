require 'simplecov'
SimpleCov.start

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'rubygems'

require 'rspec'
require 'muxie'

Dir['spec/support/**/*.rb'].each { |f| require File.expand_path(f) }
