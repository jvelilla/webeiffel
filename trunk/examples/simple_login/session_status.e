indexing
	description: "Access to information associated with the user session"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date: 2006-04-17 03:42:40 -0300 (Mon, 17 Apr 2006) $"
	revision: "$Revision: 491 $"
	copyright: "(c) 2005 Neal L. Lester and others"
	license: "Eiffel Forum License Version 2 (see forum.txt)"

class
	SESSION_STATUS

inherit
	GOA_SESSION_STATUS
		redefine
			initialize
		end

create
	make

feature -- Attributes

	name: STRING_8

	password: STRING_8

	is_male: BOOLEAN

    token: STRING
		--  session token

feature -- Setting Attributes

	set_name (new_name: STRING_8)
		require
			valid_new_name: new_name /= Void
		do
			name := new_name
		ensure
			name_updated: equal (name, new_name)
		end

	set_password (new_password: STRING_8)
			--
		require
			valid_new_password: new_password /= Void
		do
			password := new_password
		end

	set_token (new_token: STRING) is
			-- Set session token
		require
			valid_new_token: new_token /= Void
		do
			token := new_token
		ensure
			token_updated: equal (token, new_token)
		end

feature -- Access
     valid_user:BOOLEAN is
      	do
      		Result:=name.is_equal ("admin") and password.is_equal ("password")
      	end

    is_authenticated: BOOLEAN is
			-- Is this session authenticated?
		do
			Result := not token.is_empty
		end

	authenticate is
			-- Authenticate and on success, retrieve the session token and the user profile
		local
			new_session_token: STRING
		do
			if name /= Void and password /= Void and not name.is_empty and valid_user then
				new_session_token:= name + password
				set_token (new_session_token)
			end

			if is_authenticated then
	                -- Perfil del Usuario
	                print("right credentials")
			end
		end


feature {GOA_APPLICATION_SERVLET} -- Initialization

	initialize (processing_result: REQUEST_PROCESSING_RESULT)
		do
			clear
			Precursor (processing_result)
		end

	clear
			-- Clear current session
		do
			create name.make_empty
			create password.make_empty
			create token.make_empty
		end

   logout is
			-- Logout and clear current session
		do
			clear
		end
invariant
	valid_name: initialized implies name /= Void

end -- class SESSION_STATUS

