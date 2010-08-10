note
	description: "Single threaded echo server."
	date: "$Date: 2009-05-08 11:53:02 -0700 (Fri, 08 May 2009) $"
	revision: "$Revision: 78576 $"

class
	NANO_SERVER

inherit

	INET_PROPERTIES

	SHARED_DOCUMENT_ROOT

create
	make

feature {NONE} -- Initialization

	make
		local
			port: INTEGER
			prefer_ipv4_stack: BOOLEAN
			listen_socket: NETWORK_STREAM_SOCKET
			accept_timeout: INTEGER
			l_address: detachable NETWORK_SOCKET_ADDRESS
		do
			port := 9090

			io.put_string ("starting nano_server")
			io.put_string (" port = ")
			io.put_integer (port)
			io.put_new_line
			io.put_string ("%NDocument Root:" + document_root +"%N")
			document_root_cell.put (document_root)



				-- Create the Server socket
			create listen_socket.make_server_by_port (port)

			if not listen_socket.is_bound then
				io.put_string ("Unable bind to port "+ port.out)
				io.put_new_line
			else
				l_address := listen_socket.address
				check l_address_attached: l_address /= Void end
				io.put_string ("Listening on address = " + l_address.host_address.host_address + " port = " + l_address.port.out)
				io.put_new_line
					-- Listen on Server Socket with queue length = 2
				listen_socket.listen (2)
					-- Set the accept timeout
				listen_socket.set_accept_timeout (accept_timeout)
				perform_accept_serve_loop (listen_socket)
			end
			listen_socket.close
			io.put_string ("finish echo_server%N")
		end


	document_root: STRING is "./webroot"

feature {NONE} -- Implementation

	perform_accept_serve_loop (socket: NETWORK_STREAM_SOCKET)
		require
			valid_socket: socket /= Void and then socket.is_bound
		local
			l_http_protocol_handler : HTTP_PROTOCOL_HANDLER
		do
			create l_http_protocol_handler.make (socket)
		end


end
