require 'socket'                # Get sockets from stdlib




#my_ip = (require 'open-uri' ; open("http://myip.dk") { |f| /([0-9]{1,3}\.){3}[0-9]{1,3}/.match(f.read)[0].to_a[0] })
my_ip = "172.16.131.200"


server = TCPServer.open(80)   # Socket to listen on port 80
#     include Socket::Constants
#     socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
#     sockaddr = Socket.pack_sockaddr_in( 2200, 'localhost' )
#     socket.bind( sockaddr )
#     socket.listen( 5 )
test = 0



loop {                          # Servers run forever
  Thread.start(server.accept) do |client|
    client.puts(Time.now.ctime) # Send the time to the client
	client.puts "Closing the connection. Bye!"
    client.close                # Disconnect from the client
		test = test +1
	puts test
  end
}