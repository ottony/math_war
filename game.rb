require 'pry'
require 'gosu'

Dir['./app/**/*.rb'].each { |f| require_relative f }

loop do
  Window.new.show
  sleep 1.0/5
end
