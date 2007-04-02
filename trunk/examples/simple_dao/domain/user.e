indexing
	description: "Object that represent Users."
	author: "jvelilla"
	date: "$Date$"
	revision: "$Revision$"

class USER

create
	make, make_empty

feature {NONE} -- Initialization

	make (a_guid: STRING; a_username: STRING; a_password: STRING; a_first_name: STRING; a_last_name: STRING; an_email: STRING; a_description: STRING)
				-- Create a user
		require
			guid_not_void: a_guid /= Void
			guid_not_empty: a_guid.is_integer
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
			password_not_void: a_password /= Void
			password_not_empty: not a_password.is_empty
			first_name_not_void: a_first_name /= Void
			last_name_not_void: a_last_name /= Void
			email_not_void: an_email /= Void
			description_not_void: a_description /= Void
		do
			guid_value := a_guid.to_integer
			username_value := a_username
			password_value := a_password
			first_name_value := a_first_name
			last_name_value := a_last_name
			email_value := an_email
			description_value := a_description
		end

	make_empty (a_guid: STRING; a_username: STRING; a_password: STRING)
		is
				-- Creation a user with empty optional fields
		require
			guid_not_void: a_guid /= Void
			guid_is_integer: a_guid.is_integer
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
			password_not_void: a_password /= Void
			password_not_empty: not a_password.is_empty
		do
			make (a_guid, a_username, a_password,  "", "", "", "")
		end

feature -- Access

	guid: INTEGER is
			-- Globally unique identifier
		do
			Result := guid_value
		end

	username: STRING is
			-- Unique username for the SSO system
		do
			Result := username_value
		end



	first_name: STRING is
			-- First name
		do
			Result := first_name_value
		end

	last_name: STRING is
			-- Last name
		do
			Result := last_name_value
		end

	email: STRING is
			-- Email address
		do
			Result := email_value
		end

	description: STRING is
			-- User description
		do
			Result := description_value
		end


	password: STRING is
			-- Password
		do
			Result := password_value
		end

	verify_password (a_password: STRING): BOOLEAN is
			-- Is correct password?
		require
			password_not_void: a_password /= Void
		do
			if password_value.is_equal (a_password) then
				Result := True
			else
				Result := False
			end
		end

feature -- Modifiers

	set_password (a_password: STRING) is
			-- Set user's password
		require
			password_not_void: a_password /= Void
		do
			password_value := a_password
		end


	set_first_name (a_first_name: STRING) is
			-- Set first name
		require
			first_name_not_void: a_first_name /= Void
		do
			first_name_value := a_first_name
		end

	set_last_name (a_last_name: STRING) is
			-- Set last name
		require
			last_name_not_void: a_last_name /= Void
		do
			last_name_value := a_last_name
		end

	set_email (an_email: STRING) is
			-- Set email address
	require
		email_not_void: an_email /= Void
	do
		email_value := an_email
	end

	set_description (a_description: STRING) is
			-- Set description
	require
		description_not_void: a_description /= Void
	do
		description_value := a_description
	end



feature -- Implementation

	guid_value: INTEGER
		-- Globally unique identifier

	username_value: STRING
		-- Username

	password_value: STRING
		-- Password

	first_name_value: STRING
		-- First name

	last_name_value: STRING
		-- Last name

	email_value: STRING
		-- Email address

	description_value: STRING
		-- Description


    to_string: STRING is
    		--
    		do
    			Result:= "user_name:" + username + "%N" + "first_name:" + first_name + "%N" + "last_name:" + last_name + "%N" + "email:" + email + "%N"

     		end

invariant
	username_not_void: username_value /= Void

end -- USER
