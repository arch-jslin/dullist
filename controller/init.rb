module Dullist
  class Controller < Ramaze::Controller
    layout :default
    engine :Etanni
    helper :form
  end
end

require 'controller/actions'
