require 'pry'
require 'gosu'

Dir['app/**/*.rb'].each { |f| require File.join( __dir__, '..', f) }

