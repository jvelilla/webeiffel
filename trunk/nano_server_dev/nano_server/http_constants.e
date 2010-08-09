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

feature -- General Header Fields

	-- There are a few header fields which have general applicability for both request and response messages,
	-- but which do not apply to the entity being transferred.
	-- These header fields apply only to the message being transmitted.

	Cache_control 		: STRING is "Cache-Control"
	Connection    		: STRING is "Connection"
	Date          		: STRING is "Date"
	Pragma		  		: STRING is "PRAGMA"
	Trailer       		: STRING is "Trailer"
	Transfer_encoding 	: STRING is "Transfer-Encoding"
	Upgrade           	: STRING is "Upgrade"
	Via               	: STRING is "Via"
	Warning           	: STRING is "Warning"


feature -- Request Header
	Accept	 			: STRING is "Accept"
	Accept_charset 		: STRING is "Accept-Charset"
	Accept_encoding 	: STRING is "Accept-Encoding"
	Accept_language 	: STRING is "Accept-Language"
	Authorization 		: STRING is  "Authorization"
	Expect 		  		: STRING is "Expect"
	From_header   		: STRING is "From"
	Host				: STRING is "Host"
	If_match			: STRING is "If-Match"
	If_modified_since 	: STRING is "If-Modified-Since"
	If_none_match		: STRING is "If-None-Match"
	If_range			: STRING is "If-Range"
	If_unmodified_since : STRING is "If-Unmodified-Since"
	Max_forwards 		: STRING is "Max-Forwards"
	Proxy_authorization	: STRING is "Proxy-Authorization"
	Range				: STRING is "Range"
    Referer             : STRING is "Referrer"
    TE					: STRING is "TE"
    User_agent 			: STRING is "User-Agent"


feature -- Entity Header

	Allow 				: STRING is "Allow"
	Content_encoding 	: STRING is "Content-Encoding"
	Content_language 	: STRING is "Content-Language"
	Content_length	 	: STRING is "Content-Length"
	Content_location 	: STRING is "Content-Location"
	Content_MD5			: STRING is "Content-MD5"
	Content_range 		: STRING is "Content-Range"
	Content_type		: STRING is "Content-Type"
	Expires				: STRING is "Expires"
	Last_modified		: STRING is "Last-Modified"


feature -- Http Method
	Options : STRING is "OPTIONS"
	Get : STRING is "GET"
	Head : STRING is "HEAD"
	Post : STRING is "POST"
	Put  : STRING is "PUT"
	Delete : STRING is "DELETE"
	Trace : STRING is "TRACE"
	Connect : STRING is "CONNECT"
end
