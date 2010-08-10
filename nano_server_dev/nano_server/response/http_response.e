
class HTTP_RESPONSE

inherit

	HTTP_CONSTANTS

creation

	make

feature -- response header fields

	status_code: STRING
			-- status

	content_length_data : STRING
			-- length		

	set_content_length (new_content_length: STRING) is
		require
			not_void: new_content_length /= Void
		do
			content_length_data := new_content_length
		end

	set_status_code (new_status_code: STRING) is
		require
			not_void: new_status_code /= Void
		do
			status_code := new_status_code
		end

	reason_phrase: STRING
			-- message, if any

	set_reason_phrase (new_reason_phrase: STRING) is
		require
			not_void: new_reason_phrase /= Void
		do
			reason_phrase := new_reason_phrase
		end

	content_type_data: STRING
			-- type of content in this reply (eg. text/html)

	set_content_type (new_content_type: STRING) is
		require
			not_void: new_content_type /= Void
		do
			content_type_data := new_content_type
		end

feature -- creation

	make is
		do
			-- set default values for the reply
			status_code := ok
			reason_phrase := ok_message
			content_type_data := text_html
		end

feature -- access these to send a reply


	reply_header: STRING is
			-- header
		do
			Result := clone (http_version_1_1)
			Result.extend (' ')
			Result.append (status_code)
			Result.extend (' ')
			Result.append (reason_phrase)
			Result.append (crlf)
			Result.append ("Content-type: ")
			Result.append (content_type_data)
			Result.append (crlf)
			Result.append ("Content-Length: ")
			Result.append (content_length_data)
			Result.append (crlf)
			Result.append (crlf)
			-- TODO: could add the size of data being sent here and
			-- then keep the connection alive
		end

	reply_header_continue: STRING is
			-- header
		do
			Result := clone (http_version_1_1)
			Result.extend (' ')
			Result.append (status_code)
			Result.extend (' ')
			Result.append (continue_message)
			Result.append (crlf)
			Result.append (crlf)
			-- TODO: could add the size of data being sent here and
			-- then keep the connection alive
		end


	reply_text: STRING
			-- reply text

	set_reply_text (new_text: STRING) is
			-- text could be Void
		do
			reply_text := new_text
		end

	append_reply_text (more_text: STRING) is
			-- add more text to the reply
		require
			reply_text /= Void
			more_text /= Void
		do
			reply_text.append (more_text)
		end

end
