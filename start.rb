require 'rubygems'
require 'ramaze'

class Main < Ramaze::Controller
    def index
        'Hello, world!'
    end
end

Ramaze.start