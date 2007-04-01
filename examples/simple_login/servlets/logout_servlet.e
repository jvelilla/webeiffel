indexing
	description: "Servet que permite hacer el logout de la applicacion"
	author: "Javier Velilla"
	date: ""
	revision: ""

class
	LOGOUT_SERVLET

inherit

	GOA_DISPLAYABLE_SERVLET
		redefine
			make
		end
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

creation

	make

feature {NONE} -- Initialization

	make is
		do
			Precursor
			receive_secure := True
			send_secure := True
		end

feature -- Access

	name: STRING is "logout.htm"

	new_xml_document (processing_result: REQUEST_PROCESSING_RESULT): GOA_PAGE_XML_DOCUMENT is
		do
			create Result.make_utf8_encoded
			Result.start_page_element (processing_result.virtual_domain_host.host_name, processing_result.message_catalog.logout_servlet_title, configuration.stylesheet, Void)
			receive_secure := True
			send_secure := True
		end

	add_body (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT) is
		local
			user_name, password: STRING
			session_status: SESSION_STATUS
			message_catalog: MESSAGE_CATALOG
		do
			processing_result.session_status.logout
			xml.add_text_paragraph (Void, "Logged out the Simple Web Application Login!")
			xml.end_current_element
		end

    add_footer (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT) is
		do
			-- No Footer
		end

	ok_to_display (processing_result: REQUEST_PROCESSING_RESULT): BOOLEAN is
		do
			Result :=true
		end

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
