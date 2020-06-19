#!/usr/local/bin/ruby

require 'socket'
require 'ipaddr'
require 'net/http'





 def local_ip  

   orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily  
  
   UDPSocket.open do |s|  
     s.connect '64.233.187.99', 1  
     s.addr.last  
   end  
 ensure  
  Socket.do_not_reverse_lookup = orig  
end  

my_ip = (require 'open-uri' ; open("http://myip.dk") { |f| /([0-9]{1,3}\.){3}[0-9]{1,3}/.match(f.read)[0].to_a[0] })


puts ""
puts ""
#---- nom de la machine(Foncionnel)
host = Socket.gethostname
puts "Putting Host:"
puts host
#------------------------------------------
puts ""
puts ""
#-----Ip local(Fonctionnel)
puts "Putting local_IP:"
puts local_ip
#-------------------------------
puts ""
puts ""
#------Ip Externe(Fonctionnel)
puts "Putting External IP :"
puts my_ip
#------------------------------------------------
