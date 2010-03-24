require 'rubygems'
require 'ramaze'

require 'model/init'
require 'model/task'
require 'controller/actions'

Ramaze.options.adapter.adapter = :thin
Ramaze.options.adapter.port = 3001
#Ramaze.options.mode = :live

Ramaze.start :adapter => :thin