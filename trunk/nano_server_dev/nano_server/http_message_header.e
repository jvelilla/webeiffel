note
	description: "Summary description for {HTTP_MESSAGE_HEADER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_MESSAGE_HEADER

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

end
