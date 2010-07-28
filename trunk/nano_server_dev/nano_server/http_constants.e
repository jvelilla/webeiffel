note
	description: "Summary description for {HTTP_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CONSTANTS

feature

	http_version_1_1: STRING is "HTTP/1.1"
	http_version_1_0: STRING is "HTTP/1.0"
	crlf: STRING is "%/13/%/10/"

feature -- error codes

	continue : STRING is "100"
	ok: STRING is "200"
	not_found: STRING is "404"
	server_error: STRING is "500"
	not_implemented: STRING is "501"

	-- messages
	ok_message: STRING is "OK"
	continue_message : STRING is "Continue"
	not_found_message: STRING is "URI not found"
	not_implemented_message: STRING is "Not Implemented"

feature -- content types

	text_html: STRING is "text/html"

feature -- Network

	Http_server_port: INTEGER = 9090
	Max_tcp_clients: INTEGER = 100
	Socket_accept_timeout: INTEGER = 1000
	Socket_connect_timeout: INTEGER = 5000


end
