note
	description: "Single threaded echo server."
	date: "$Date: 2009-05-08 11:53:02 -0700 (Fri, 08 May 2009) $"
	revision: "$Revision: 78576 $"

class
	NANO_SERVER

inherit

	INET_PROPERTIES

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


			io.put_string ("starting echo_server")
			io.put_string (" port = ")
			io.put_integer (port)
			io.put_new_line

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

feature {NONE} -- Implementation

	perform_accept_serve_loop (socket: NETWORK_STREAM_SOCKET)
		require
			valid_socket: socket /= Void and then socket.is_bound
		local
			done: BOOLEAN
			client_socket: detachable NETWORK_STREAM_SOCKET
		do
			from
				done := False
			until
				done
			loop
				socket.accept
				client_socket := socket.accepted
				if client_socket = Void then
						-- Some error occured, perhaps because of the timeout
						-- We probably should provide some diagnostics here
					io.put_string ("accept result = Void")
					io.put_new_line
				else
					perform_client_communication (client_socket)
				end
			end
		end

	perform_client_communication (socket: NETWORK_STREAM_SOCKET)
		require
			socket_attached: socket /= Void
			socket_valid: socket.is_open_read and then socket.is_open_write
		local
			done: BOOLEAN
			l_address, l_peer_address: detachable NETWORK_SOCKET_ADDRESS
		do
			l_address := socket.address
			l_peer_address := socket.peer_address
			check
				l_address_attached: l_address /= Void
				l_peer_address_attached: l_peer_address /= Void
			end
			io.put_string ("Accepted client on the listen socket address = "+ l_address.host_address.host_address + " port = " + l_address.port.out +".")
			io.put_new_line
			io.put_string ("%T Accepted client address = " + l_peer_address.host_address.host_address + " , port = " + l_peer_address.port.out)
			io.put_new_line
			from
				done := False
			until
				done
			loop
				if socket.socket_ok then
					done := receive_message_and_send_replay (socket)
				else
					done := True
				end
			end
			io.put_string ("Finished processing the client, address = "+ l_peer_address.host_address.host_address + " port = " + l_peer_address.port.out + ".")
			io.put_new_line
		end

	receive_message_and_send_replay (client_socket: NETWORK_STREAM_SOCKET): BOOLEAN
		require
			socket_attached: client_socket /= Void
			socket_valid: client_socket.is_open_read and then client_socket.is_open_write
		local
			message: detachable STRING
		do
			message := receive_message_internal (client_socket)
			if message /= Void  then
				io.put_string ("Client Says :")
				io.put_string (message)
				io.put_new_line
				send_reply (client_socket, message)
			else
				Result := True
			end

		end

	send_reply (client_socket: NETWORK_STREAM_SOCKET; message: STRING)
		require
			socket_attached: client_socket /= Void
			socket_valid: client_socket.is_open_write
			message_attached: message /= Void
		local
			l_response : HTTP_RESPONSE
		do
			create l_response.make
			l_response.set_reply_text (message)
			send_message (client_socket, l_response.reply_header + l_response.reply_text)
		end



	receive_message_internal (socket: NETWORK_STREAM_SOCKET) : STRING
        require
            socket: socket /= Void and then not socket.is_closed
        local
        	end_of_stream : BOOLEAN
        do

            from
                socket.read_line
                Result := ""
            until
                end_of_stream
            loop
                print ("%N" +socket.last_string+ "%N")
                Result.append(socket.last_string)
                if not socket.last_string.is_equal("%R") and socket.socket_ok  then
                	socket.read_line
        		else
        			end_of_stream := True
        		end
        	end
		end

	send_message (client_socket : NETWORK_STREAM_SOCKET ; a_msg: STRING)
		local
			a_package : PACKET
            a_data : MANAGED_POINTER
            c_string : C_STRING
		do
			 create c_string.make (a_msg)
             create a_data.make_from_pointer (c_string.item, a_msg.count + 1)
             create a_package.make_from_managed_pointer (a_data)
             client_socket.send (a_package, 1)
		end

end
