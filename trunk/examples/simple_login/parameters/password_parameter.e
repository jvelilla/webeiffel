indexing
	description: "Permite que un usuario ingrese su password"
	author: "Javier Velilla"
	date: ""
	revision: ""

class PASSWORD_PARAMETER inherit

	GOA_PASSWORD_PARAMETER
		redefine
			label_string
		end

	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT
		redefine
			commit
		end

creation
	make

feature

	name: STRING is "password"
		-- Label name

	size: INTEGER is 20
		-- Input text size

	current_value (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- Current value
		do
			Result := processing_result.session_status.password
		end

	save_current_value (processing_result: PARAMETER_PROCESSING_RESULT) is
			-- Save current value
		do
			processing_result.session_status.set_password (processing_result.value)
		end

	label_string (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- Label name
		do
			Result := processing_result.message_catalog.password_label
		end

	commit (processing_result: REQUEST_PROCESSING_RESULT) is
			-- Commit all changes to data structures.
			-- Look for the password parameter in the processing result and store it
			-- in the session status.
		local
			password: STRING
		do
			password := processing_result.parameter_value (name, 0)
			processing_result.session_status.set_password (password)
		end

end -- class PASSWORD_PARAMETER
