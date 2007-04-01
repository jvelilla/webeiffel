indexing
	description: "Shared access to the parameter processors"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date: 2006-04-17 03:42:40 -0300 (Mon, 17 Apr 2006) $"
	revision: "$Revision: 491 $"
	copyright: "(c) 2005 Neal L. Lester and others"
	license: "Eiffel Forum License Version 2 (see forum.txt)"

class 
	SHARED_REQUEST_PARAMETERS

inherit
	GOA_SHARED_REQUEST_PARAMETERS

create 
	default_create

feature 

	name_parameter: NAME_PARAMETER
			-- Allow user to input their name
		once
			create Result.make
		end

	password_parameter: PASSWORD_PARAMETER
			-- Allow user to input their password
		once
			create Result.make
		end



end -- class SHARED_REQUEST_PARAMETERS

