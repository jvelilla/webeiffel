note
	description: "Summary description for {HTTP_REQUEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_REQUEST
feature -- METHODS

	Options : STRING is "OPTIONS"
	Get     : STRING is "GET"
	Head    : STRING is "HEAD"
	Post    : STRING is "POST"
	Put     : STRING is "PUT"
	Trace   : STRING is "TRACE"
	Connect : STRING is "CONNECT"


	method : STRING
		-- current method

	set_method (new_method : STRING)
			-- set method with new_method
		do
			method := new_method
		ensure
			set_method : method = new_method
		end

end
