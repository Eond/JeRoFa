require 'socket'                
require 'ipaddr'
require 'net/http'

ip = IPAddr.new('114.23.42.42').to_i
my_ip = (require 'open-uri' ; open("http://myip.dk") { |f| /([0-9]{1,3}\.){3}[0-9]{1,3}/.match(f.read)[0].to_a[0] })
server = TCPServer.open(2000)   
     include Socket::Constants
     socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
     sockaddr = Socket.pack_sockaddr_in( 2200, 'localhost')
     socket.bind( sockaddr )
     socket.listen( 5 )
test = 0
max = 5
until test > max -1
	Thread.start(server.accept) do |client|
		client.puts(Time.now.ctime) 
		if test == max-1
			client.puts "Closing the SERVER at next Log"
			client.close                
			
		else
			client.puts "Closing the connection"
			client.close               
		end		
	end
	
	puts test + 1
	test = test +1
end


	
