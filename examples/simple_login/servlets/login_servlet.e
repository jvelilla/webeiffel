indexing
	description: "Servlet que consulta el nombre y el password al usuario "
	author: "Javier Velilla"
	date: ""
	revision: ""

class
	LOGIN_SERVLET

inherit

	GOA_DISPLAYABLE_SERVLET
		redefine
			make
		end
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

creation

	make

feature

	name: STRING is "login.htm"

	new_xml_document (processing_result: REQUEST_PROCESSING_RESULT): GOA_PAGE_XML_DOCUMENT is
		do
			create Result.make_utf8_encoded
			Result.start_page_element (processing_result.virtual_domain_host.host_name, processing_result.message_catalog.login_title, configuration.stylesheet, post_url (processing_result))
		end

	add_body (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT) is
		do
			xml.add_text_paragraph (Void, processing_result.message_catalog.login_title)
			xml.add_text_paragraph (Void, "This example not use Database")
			xml.add_text_paragraph (Void, "login with  username -> admin")
			xml.add_text_paragraph (Void, "password -> password")
            xml.add_text_paragraph (Void, "Log In")
			xml.start_data_entry_table_element (processing_result.message_catalog)
					-- Indent twice because this command opens up two XML elements
					xml.add_standard_input_row (0, name_parameter, processing_result)
					xml.add_standard_input_row (0, password_parameter, processing_result)
				xml.end_current_element
			xml.end_current_element
			xml.start_paragraph_element (Void)
				xml.add_parameter (0, standard_submit_parameter, processing_result)
			xml.end_current_element
		end

	add_footer (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT) is
		do
			-- No Footer
		end

	ok_to_display (processing_result: REQUEST_PROCESSING_RESULT): BOOLEAN is
		do
			Result := not processing_result.session_status.is_authenticated
		end

feature {NONE} -- Creation

	make is
		do
			Precursor
			expected_parameters.force_last (name_parameter.name)
			expected_parameters.force_last (password_parameter.name)
		end


end -- class LOGIN_SERVLET
