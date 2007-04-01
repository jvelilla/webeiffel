indexing
	description: "Servlet que muestra el Home Page"
	author: "Javier Velilla"
	date: ""
	revision: ""

class
	HOME_SERVLET

inherit
	GOA_DISPLAYABLE_SERVLET

	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

create
	make

feature

	name: STRING_8 is "home.htm"

	new_xml_document (processing_result: REQUEST_PROCESSING_RESULT): GOA_PAGE_XML_DOCUMENT
		do
			create Result.make_utf8_encoded
			Result.start_page_element (processing_result.virtual_domain_host.host_name, processing_result.message_catalog.home_title, configuration.stylesheet, Void)
		end

	add_body (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT)
		local
			user_name: STRING_8
			session_status: SESSION_STATUS
			message_catalog: MESSAGE_CATALOG
		do
			session_status := processing_result.session_status
			message_catalog := processing_result.message_catalog
			user_name := session_status.name
			xml.add_text_paragraph (Void, processing_result.message_catalog.home_title)
			xml.add_text_paragraph (Void, "This is a simple Home Page")
   			xml.add_text_paragraph (Void, message_catalog.comment (user_name))
			xml.start_paragraph_element (Void)
			xml.add_item (logout_servlet.hyperlink (processing_result, message_catalog.link_to_logout_servlet_text))
			xml.end_current_element
		end

	add_footer (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT)
		do
		end

	ok_to_display (processing_result: REQUEST_PROCESSING_RESULT): BOOLEAN
		local
			session_status: SESSION_STATUS
		do
			session_status := processing_result.session_status
			Result := session_status.is_authenticated
		end


end -- class HOME_SERVLET

