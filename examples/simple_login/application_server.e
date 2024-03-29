indexing
	description: "Demonstration of Goanna Web Application Framework"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date: 2007-02-20 20:59:51 -0300 (Tue, 20 Feb 2007) $"
	revision: "$Revision: 547 $"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	APPLICATION_SERVER

inherit

	GOA_APPLICATION_SERVER
		rename
			warn as log_warn
		redefine
			connection_reset_by_peer_exception_occurred
		end
	GOA_FAST_CGI_SERVLET_APP
		undefine
			initialise_logger, all_servlets_registered
		redefine
			connection_reset_by_peer_exception_occurred
		end
	SHARED_SERVLETS

create

	application_make

feature

	command_line_ok: BOOLEAN is
		local
			a_host: VIRTUAL_DOMAIN_HOST
		do
			create active_configuration
			touch_configuration
			create a_host
			a_host.set_host_name (configuration.default_virtual_host_lookup_string)
			register_virtual_domain_host (a_host, configuration.default_virtual_host_lookup_string)
			Result := True
		end

	register_servlets is
		do
			register_servlet (login_servlet)
			servlet_manager.register_default_servlet (login_servlet)
			register_servlet (home_servlet)
		end

	connection_reset_by_peer_exception_occurred is
		do
			Precursor {GOA_FAST_CGI_SERVLET_APP}
			Precursor {GOA_APPLICATION_SERVER}
		end


end -- class MSP_SERVER
