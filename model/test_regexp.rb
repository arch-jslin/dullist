r = Regexp.new(
'( (http|https|ftp)://)*'+       
  '( (\d{1,3}\.){3,3}\d{1,3}|'+  
    '((-|\w)+\.)+(tw|com|aero|us|gr)|'+ 
    '((-|\w)+\.)*localhost )'+  
  '(:\d{1,5})?'+                 
  '(/\S+)*' ,Regexp::EXTENDED)

#str.gsub(/((http|https|ftp):\/\/)*((\d{1,3}\.){3,3}\d{1,3}|((-|\w)+\.)+(tw|com|aero|us|gr)|((-|\w)+\.)*localhost)(:\d{1,5})?(\/\S+)*/)