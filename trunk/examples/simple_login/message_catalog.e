indexing
	description: "Messages displayed to the user"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date: 2006-04-17 03:42:40 -0300 (Mon, 17 Apr 2006) $"
	revision: "$Revision: 491 $"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	MESSAGE_CATALOG

inherit

	GOA_ENGLISH_CONTENT_FACILITIES
	GOA_MESSAGE_CATALOG
	GOA_SHARED_APPLICATION_CONFIGURATION


feature -- Messages

	home_title: STRING is "My Home Page..."

	login_title: STRING is "Welcome to Login Page!..."

	name_label: STRING is "Name"

	logout_servlet_title: STRING is "Logout"

	link_to_logout_servlet_text: STRING is "Logout"

	comment (name: STRING): STRING is
			-- Response to send user to their answers
		require
			valid_name: name /= Void and then not name.is_empty
		local
		do
			Result := 	name + " is " + "logged into the system"	end

end -- class MESSAGE_CATALOG
