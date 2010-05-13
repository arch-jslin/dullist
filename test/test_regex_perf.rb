module Dullist
  require 'helper/helper'
  SUFFIX2   = 'biz|com|edu|gov|info|mil|name|net|org'+
              '|aq|au|br|ca|ch|cn|cr|cz|de|dk|eg|es|eu|fi|fr|gr|hk|it|jp|kr|nl|no|ru|se|tw|uk|us'
  AUTOLINK_REGEX2 = Regexp.new(
    '( (http|https|ftp)://)*'+       #protocol is not necessarily needed. if not, http is used.
    '( (\d{1,3}\.){3,3}\d{1,3}|'+  #the second part: it could be IPv4
      '((-|\w)+\.)+('+SUFFIX2+')|'+#  or suffixed with a valid domain
      '((-|\w)+\.)*localhost )'+   #  or localhost
    '(:\d{1,5})?'+                 #the third part: port number
    '(/\S+)*', Regexp::EXTENDED)   #the last part : just get everything.
    
  def Dullist.regex_perf

str = 'http://lalala
https://123.345
haha://www.google.com
www.guugle.ccc
aaa.aero
aaa.us
aaa.pp
aaa.gr
str.map_with_index{|g,i|p\'i\'+g}.tw 
str.map{.tw str.map(.tw str.map#.tw str.map.tw#123 str.map/.tw str..map.tw
str.map.tw/{}()#123&%234234 aosi-oid.tw str.m[p.tw str.+()123.tw str.map.tw#{}sdf
str.map.tw2384u29{}23498
http://localhost:2398 todo.localhost:444 
http://github.com/archilifelin/dullist/blob/master/helper/helper.rb
https://mail.google.com/mail/?ui=2&shva=1#buzz
'
  t = Time.now
  10000.times {
    str.gsub(AUTOLINK_REGEX2) {|p|
      temp = p
      temp = 'http://' + p if (p[0..3] != 'http' && p[0..2] != 'ftp')
      "<a href='#{temp}' target='_blank'>#{p}</a>"
    }
  }
  p Time.now - t
  
  t = Time.now
  10000.times {
    Helper.parse_link(str)
  }
  p Time.now - t
  end
end #Dullist

Dullist.regex_perf