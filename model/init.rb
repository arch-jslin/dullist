require 'sequel'

Sequel::Model.plugin(:schema)
DB = Sequel.sqlite('todolist.db')
