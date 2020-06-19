require 'socket'      # Sockets are in standard library
require 'ipaddr'
require 'net/http'

host = Socket.gethostname
port = 2000
my_ip = (require 'open-uri' ; open("http://myip.dk") { |f| /([0-9]{1,3}\.){3}[0-9]{1,3}/.match(f.read)[0].to_a[0] })
iplocal = IPSocket.getaddress(host)
s = TCPSocket.open(iplocal, port)

while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
s.close               # Close the socket when done
