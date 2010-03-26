module Dullist
  require 'sequel'

  Sequel::Model.plugin(:schema)
  DB = Sequel.sqlite(__DIR__'../dullist.db')
end

require 'model/task'