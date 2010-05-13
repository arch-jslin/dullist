module Dullist
  require 'set' #for converting array to set
  module Helper
    PROTOCOL = 'http|https|ftp'
    SUFFIX   = ('biz|com|edu|gov|info|mil|name|net|org'+
                '|aq|au|br|ca|ch|cn|cr|cz|de|dk|eg|es|eu|fi|fr|gr|hk|it|jp|kr|nl|no|ru|se|tw|uk|us').split('|').to_set
    AUTOLINK_REGEX = Regexp.new(
      '( ('+PROTOCOL+')://)*'+       #protocol is not necessarily needed. if not, http is used.
      '( (\d{1,3}\.){3,3}\d{1,3}|'+  #the second part: it could be IPv4
        '((-|\w)+\.)+(\w+)|'+        #  or suffixed with a valid domain (we match the suffix($7) in gsub)
        '((-|\w)+\.)*localhost )'+   #  or localhost
      '(:\d{1,5})?'+                 #the third part: port number
      '(/\S+)*', Regexp::EXTENDED)   #the last part : just get everything.
      
    def Helper.parse_link(str)
      str.gsub(AUTOLINK_REGEX) {|match| 
        if SUFFIX.include?($7)      
          make_href(match, match) 
        else 
          match
        end
      }        
    end
    def Helper.make_href(link, orig_str)
      if link == nil || link.length < 1
        orig_str
      else
        temp = link
        temp = 'http://' + link if (link[0..3] != 'http' && link[0..2] != 'ftp')
        "<a href='#{temp}' target='_blank'>#{orig_str}</a>"
      end
    end
  end #Helper
end #Dullist