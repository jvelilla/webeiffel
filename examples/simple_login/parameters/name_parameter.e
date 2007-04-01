indexing
	description: "Allow user to enter their name"
	author: "Javier Velilla"
	date: ""
	revision: ""


class
	NAME_PARAMETER

inherit

	GOA_NON_EMPTY_UPDATE_INPUT_PARAMETER
	    redefine
	    	process
	    end
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

creation

	make

feature

	name: STRING is "name"

	size: INTEGER is 25

	current_value (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
		do
			Result := processing_result.session_status.name
		end

	save_current_value (processing_result: PARAMETER_PROCESSING_RESULT) is
		do
			processing_result.session_status.set_name (processing_result.value)
		end

	label_string (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
		do
			Result := processing_result.message_catalog.name_label
		end

     process (processing_result: PARAMETER_PROCESSING_RESULT) is
     do
         Precursor {GOA_NON_EMPTY_UPDATE_INPUT_PARAMETER}(processing_result)
         start_transaction (processing_result.request_processing_result)
         if not processing_result.session_status.valid_user then
              processing_result.error_message.add_message("Name or Password are Incorrect")
         end
         commit (processing_result.request_processing_result)
     end


end -- class NAME_PARAMETER
