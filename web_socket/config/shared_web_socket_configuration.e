note
	description: "Summary description for {SHARED_WEB_SOCKET_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_WEB_SOCKET_CONFIGURATION

feature

	ws_config : WEB_SOCKET_CONFIGURATION
		once
			create Result.make
		end
end
