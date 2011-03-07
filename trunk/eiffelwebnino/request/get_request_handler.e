class GET_REQUEST_HANDLER

inherit

	SHARED_DOCUMENT_ROOT

	SHARED_URI_CONTENTS_TYPES

	HTTP_REQUEST_HANDLER

	HTTP_CONSTANTS

feature

	process
			-- process the request and create an answer
		local
			fname: STRING
			f: RAW_FILE
			ctype, extension: STRING
		do
			create answer.make
			if request_uri.is_equal ("/") then
				process_default
				answer.set_content_type ("text/html")
			else
				fname := document_root_cell.item.twin
				fname.append (request_uri)
				debug
					print ("URI name: " + fname )
				end
				create f.make (fname)
				create answer.make
				if f.exists then
					extension := ct_table.extension (request_uri)
					ctype := ct_table.content_types.item (extension)
					if ctype = Void then
							process_raw_file (f)
							answer.set_content_type ("text/html")
					else
						if ctype.is_equal ("text/html") then
								process_text_file (f)
							else
								process_raw_file (f)
							end
							answer.set_content_type (ctype)
						end
					else
						answer.set_status_code (not_found)
						answer.set_reason_phrase (not_found_message)
						answer.set_reply_text ("Not found on this server")
					end
			end
			answer.set_content_length (answer.reply_text.count.out)
		end

	process_default
			-- Return a defaul response
			local
				html : STRING
			do
  			 answer.set_reply_text ("")
			 html := " <html> <head> <title> NINO HTTPD </title> " +
				"	    </head>   " +
				"       <body>    " +
				" 		<h1> Welcome to NINO HTTPD! </h1> "+
				" <p>  Default page  " +

				" </p> " +
				" </body> " +
				" </html> "
				answer.append_reply_text (html)
			end


	process_text_file (f: FILE)
			-- send a text file reply
		require
			valid_f: f /= Void
		do
			f.open_read
			from
				answer.set_reply_text ("")
				f.read_line
			until f.end_of_file
			loop
				answer.append_reply_text (f.last_string)
				answer.append_reply_text (crlf)
				f.read_line
			end
			f.close
		end

	process_raw_file (f: FILE)
			-- send a raw file reply
		require
			valid_f: f /= Void
		do
			-- this is not quite right....
			f.open_read
			from
				answer.set_reply_text ("")
			until f.end_of_file
			loop
				f.read_stream_thread_aware (1024)
				answer.append_reply_text (f.last_string)
			end
			f.close
		end


end
