require 'pry'
require 'gosu'

require './app/debug.rb'
Dir['app/**/*.rb'].each { |f| require File.join( __dir__, '..', f) }

