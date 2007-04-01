indexing
	description: "Shared Access to Servlets"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date: 2006-04-17 03:42:40 -0300 (Mon, 17 Apr 2006) $"
	revision: "$Revision: 491 $"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	SHARED_SERVLETS

inherit

	GOA_SHARED_SERVLETS

feature -- Servlets

	login_servlet: LOGIN_SERVLET is
			-- Servlet that asks the user name and password
		once
			create Result.make
		end

	home_servlet: HOME_SERVLET is
			-- Servlet that displays the application home page
		once
			create Result.make
		end

	logout_servlet: LOGOUT_SERVLET is
			-- Servlet that asks the user name and password
		once
			create Result.make
		end

end -- class SHARED_SERVLETS
