require 'rubygems'
require 'ramaze'

require 'controller/init'
require 'model/init'

Ramaze.options.adapter.handler = :thin
Ramaze.options.adapter.port = 3001
#Ramaze.options.mode = :live

Ramaze.start