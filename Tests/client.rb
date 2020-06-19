#require 'socket'      # Sockets are in standard library
#require 'ipaddr'
#require 'net/http'

#host = Socket.gethostname
#port = 80
#my_ip = (require 'open-uri' ; open("http://myip.dk") { |f| /([0-9]{1,3}\.){3}[0-9]{1,3}/.match(f.read)[0].to_a[0] })
#iplocal = IPAddr.new("172.16.131.200").to_i
#s = TCPSocket.open(iplocal, port)

#while line = s.gets   # Read lines from the socket
#  puts line.chop      # And print with platform line terminator
#end
#s.close               # Close the socket when done

require 'socket'      # Sockets are in standard library

#hostname = '205.237.9.16'
#hostname = '172.16.125.52'
port = 2000

s = TCPSocket.open('localhost', port)

while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
s.close               # Close the socket when done

