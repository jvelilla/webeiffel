note
	description: "Summary description for {HTTP_CONNECTION_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CONNECTION_HANDLER

inherit

	THREAD

create
	make

feature {NONE} -- Initialization

	make (a_main_server: like main_server; a_name: STRING)
			-- Creates a {HTTP_CONNECTION_HANDLER}, assigns the main_server and sets the current_request_message to empty.
			--
			-- `a_main_server': The main server object
			-- `a_name': The name of this module
		require
			a_main_server_attached: a_main_server /= Void
			a_name_attached: a_name /= Void
		do
			main_server := a_main_server
	       	create current_request_message.make_empty
	       	create current_method.make_empty
			create current_uri.make_empty
			create request_header_map.make (3)
            is_stop_requested := False
         ensure
           main_server_set: a_main_server ~ main_server
           current_request_message_attached: current_request_message /= Void
   	end

feature -- Inherited Features

	execute
			-- <Precursor>
			-- Creates a socket and connects to the http server.
		local
			l_response: STRING
			l_http_socket: detachable TCP_STREAM_SOCKET
			l_debug_level: INTEGER
			answer : HTTP_RESPONSE
			l_method : STRING
			l_uri :    STRING
		do
			is_stop_requested := False
			create l_http_socket.make_server_by_port ({HTTP_CONSTANTS}.Http_server_port)
			l_http_socket.set_reuse_address
			if not l_http_socket.is_bound then
				print ("Socket could not be bound on port " + {HTTP_CONSTANTS}.Http_server_port.out )
			else
				from
	                l_http_socket.listen ({HTTP_CONSTANTS}.Max_tcp_clients)
	               print ("%NHTTP Connection Server ready on port " + {HTTP_CONSTANTS}.Http_server_port.out +"%N")
	            until
	            	is_stop_requested
	            loop
	                l_http_socket.accept
	                if not is_stop_requested then
			            if attached l_http_socket.accepted as l_thread_http_socket then

			            	 if receive_message_from_http(l_thread_http_socket) then
								l_response := current_request_message
							else
								l_response := "%Ninternal Server Error%N"
								print ("%NError decoding message from http server plugin!%N")
							end
							l_uri := current_uri
							l_method := current_method
							print ("%Nl_uri:" + l_uri +"%N")
							print ("%Nl_method:" + l_method +"%N")
							if current_method.is_equal("GET") then
								-- not supported method - send error reply
								create answer.make
								answer.set_reply_text ("Current Method :" + l_method )
								l_response := answer.reply_header + answer.reply_text
								send_message_to_http_server (l_response,l_thread_http_socket)
							elseif current_method.is_equal("POST") then
								create answer.make
								answer.set_status_code (answer.continue)
								l_thread_http_socket.put_string ("HTTP/1.1 100 Continue%/13/%/10/")
							else
								create answer.make
								answer.set_reply_text ("Current Method :" )
								l_response := answer.reply_header + answer.reply_text
								send_message_to_http_server (l_response,l_thread_http_socket)
							end

				         	l_thread_http_socket.close_socket
				            check
				            	socket_closed: l_thread_http_socket.is_closed
				            end
						end
					end
	            end
	            l_http_socket.cleanup
	        	check
	        		socket_is_closed: l_http_socket.is_closed
	       		end
       		end
       		print ("HTTP Connection Server ends.")
       	rescue
       		print ("HTTP Connection Server Module shutdown due to exception. Please relaunch manually.")

			if attached l_http_socket as ll_http_socket then
				ll_http_socket.cleanup
				check
	        		socket_is_closed: ll_http_socket.is_closed
	       		end
			end
			is_stop_requested := True
	    	retry
       	end

feature -- Access

	is_stop_requested: BOOLEAN
			-- Set true to stop accept loop


feature {NONE} -- Access

	request_header_map : HASH_TABLE [STRING,STRING]
			-- Containts key value of the header

	main_server: HTTP_SERVER
			-- The main server object

	current_request_message: STRING
			-- Stores the current request message received from http server

	Max_fragments: INTEGER = 1000
			-- Defines the maximum number of fragments that can be received

	current_method :  STRING
		-- http verb

	current_uri   :	 STRING
		--  http endpoint		


feature -- Status setting

	shutdown
			-- Stops the thread
		do
			is_stop_requested := True
		end

feature {NONE} -- Implementation


	encode_string (a_dest: MANAGED_POINTER; a_message: STRING; a_start_index, a_end_index: NATURAL; a_fragment: BOOLEAN)
			-- Encodes the string so that it can be sent over the net and be read by the http server plugin.
			--
			-- `a_dest': A destination address for the data
			-- `a_message': The data source
			-- `a_start_index': Read the characters in a_message from here...
			-- `a_end_index': ...until here.
			-- `a_fragment': Defines if this is a message fragment or not.
		require
			data_attached: a_dest /= Void
			data_is_allocatd: a_dest.count > 0
			index_plausible: a_start_index < a_end_index
			start_index_in_boundaries: a_start_index > 0 and a_start_index <= a_message.count.as_natural_32
			end_index_in_boundaries: a_end_index > 0 and a_end_index <= a_message.count.as_natural_32+1
		local
			l_encoder: HTTP_ENCODING_FACILITIES
			i: NATURAL
		do
			create l_encoder.make
			a_dest.put_natural_32_be
				(l_encoder.encode_natural ((a_end_index - a_start_index).as_natural_32, a_fragment), 0)
			from
				i := a_start_index
			until
				i > a_end_index-1
			loop
				a_dest.put_character (a_message [i.as_integer_32], i.as_integer_32 - a_start_index.as_integer_32 + {PLATFORM}.natural_32_bytes)
				i := i + 1
			variant
				(a_end_index - i).as_integer_32
			end
		end

	read_string_from_socket (a_socket: TCP_STREAM_SOCKET; a_n: NATURAL): STRING
			-- Reads characters from the socket and concatenates them to a string
			--
			-- `a_socket': The socket to read from
			-- `a_n': The number of characters to read
			-- `Result': The created string
		require
			socket_is_open: not a_socket.is_closed
		local
			l_read_size: INTEGER
			l_buf: detachable STRING
			l_http_socket : TCP_STREAM_SOCKET
		do
			create Result.make (a_n.as_integer_32)
			from
				l_read_size := 0
				Result := ""
				l_buf := ""
			until
				l_buf.is_equal ("%R")
			loop
				a_socket.read_line_thread_aware
				l_buf := a_socket.last_string
				if l_buf /= Void then
					Result.append (l_buf)
				end
				if l_buf.is_equal ("%R") then
					a_socket.set_nodelay
					a_socket.put_string ("HTTP/1.1 100 Continue%/13/%/10/%/13/%/10/")
					a_socket.close_socket
				end

				l_read_size := Result.count
			end
		ensure
			Result_attached: Result /= Void
		end



feature -- New implementation

	send_message_to_http_server (a_message: STRING; a_http_socket: TCP_STREAM_SOCKET)
			-- Sends a string over the specified socket.
			--
			-- `a_message': The message to be sent
			-- `a_http_socket': The socket to be used
		require
			a_http_socket_attached: a_http_socket /= Void
			a_http_socket_is_open: not a_http_socket.is_closed
			a_message_attached: a_message /= Void
			a_message_not_empty: not a_message.is_empty
		local
			l_data: MANAGED_POINTER
			l_fragment: BOOLEAN
			l_index, l_message_size, l_fragment_size: NATURAL
		do
			print ("%NSending response to http%N")
			a_http_socket.send_message (a_message)
		end


	receive_message_from_http (a_http_socket: TCP_STREAM_SOCKET): BOOLEAN
			-- Decodes an incoming message and stores it in current_request_message. Returns true if sucessful
			--
			-- `a_http_socket': The socket to read from
			-- `Result': Returns true if receiving was successful.
		require
			a_http_socket: a_http_socket /= Void and then not a_http_socket.is_closed
		local
			l_response: STRING
			l_msg: HTTP_MESSAGE
			l_frag_counter: INTEGER
			l_buf: STRING
			l_error: BOOLEAN
			l_retried: BOOLEAN
			encoder: HTTP_ENCODING_FACILITIES
		do
			print ("%NDebug entry: receive_message_from_http_2 %N")
			Result := True
			if	a_http_socket.is_open_read then
					if a_http_socket.is_readable then
						print ("%N--- Received: %N")
						print (a_http_socket.last_string)
						print ("%N---------%N")
						a_http_socket.read_line_thread_aware
						-- parse the request line to see
						parse_http_request_line (a_http_socket.last_string)
					end
		 	  	else
            		Result := False
            		print ("%NException while receiving message%N")
            	end
         end



   parse_http_request_body (a_http_socket: TCP_STREAM_SOCKET)
        require
            a_http_socket: a_http_socket /= Void and then not a_http_socket.is_closed
        local
            pos, next_pos: INTEGER
            l_response : STRING
            l_list : LIST[STRING]
            l_http_socket : TCP_STREAM_SOCKET
            a_package : PACKET
            a_data : MANAGED_POINTER
            c_string : C_STRING
        do
            print ("%N Read Body %N")
            from
                a_http_socket.read_line_thread_aware
            until
                a_http_socket.last_string = void or a_http_socket.last_string.is_equal ("%R")
            loop
                print ("%N" +a_http_socket.last_string+ "%N")
                a_http_socket.read_line_thread_aware
                if a_http_socket.last_string.is_equal ("%R") then
                    create c_string.make ("HTTP/1.1 100 Continue%/13/%/10/%/13/%/10/")
                    create a_data.make_from_pointer (c_string.item, c_string.bytes_count)
                    create a_package.make_from_managed_pointer (a_data)
                    a_http_socket.send (a_package, 1)
                    a_http_socket.read_stream (15)
                    a_http_socket.put_integer_64 (10)
                    print ("%Nlast_string:"+ a_http_socket.last_string)
                end

            end
        end

	parse_http_request_line (line: STRING)
		require
			line /= Void
		local
			pos, next_pos: INTEGER
		do
			print ("%N parse http request line:%N" + line)
			-- parse (this should be done by a lexer)
			pos := line.index_of (' ', 1)
			current_method := line.substring (1, pos - 1)
			next_pos := line.index_of (' ', pos+1)
			current_uri := line.substring (pos+1, next_pos-1)
		ensure
			not_void_method: current_method /= Void
		end


invariant
	main_server_attached: main_server /= Void
	current_request_message_attached: current_request_message /= Void

end
