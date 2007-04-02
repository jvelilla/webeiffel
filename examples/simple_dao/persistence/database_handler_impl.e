indexing
	description: "Database handler for ODBC."
	author: "Samuele Lucchini <origo@muele.net>"
	date: "$Date$"
	revision: "$Revision$"

class DATABASE_HANDLER_IMPL inherit

	DAO_DATABASE_HANDLER

	DAO_DATABASE_CONFIG

create
	make,
	make_common

feature {NONE} -- Initialization

	make_common is
			-- Create a database hander for ODBC with common settings
		do
			create db_application.login (db_config_username, db_config_password)
			db_application.set_hostname (db_config_hostname)
			db_application.set_data_source (db_config_database_name)
			db_application.set_base

			create db_control.make
			create last_query.make_now
			keep_connection := db_config_keep_connection

			if keep_connection then
				connect
			end
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
			last_query_not_void: last_query /= Void
		end


	make (a_username: STRING; a_password: STRING; a_hostname : STRING; a_database_name: STRING; connection: BOOLEAN)
		is
				-- Create a database handler for ODBC
		require
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
			password_not_void: a_password /= Void
			hostname_not_void: a_hostname /= Void
			hotname_not_empty: not a_hostname.is_empty
			database_name_not_void: a_database_name /= Void
			database_name_not_empty: not a_database_name.is_empty
		do
			create db_application.login (a_username, a_password)
			db_application.set_hostname (a_hostname)
			db_application.set_data_source (a_database_name)
			db_application.set_base

			create db_control.make
			create last_query.make_now
			keep_connection := connection

			if keep_connection then
				connect
			end
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
			last_query_not_void: last_query /= Void
		end

feature -- Functionality

	execute_query is
			-- Execute query
		local
			container : ARRAYED_LIST[DB_RESULT]
			select_query: DAO_DB_QUERY_SELECT
		do
			if not keep_connection then
				connect
			end

			create db_selection.make
			db_selection.set_query (query.sql)
			db_selection.execute_query

			select_query ?= query
			if select_query /= Void then
					-- Load query result only for SELECT queries
				create container.make (100)
				db_selection.set_container (container)
				db_selection.load_result
				items ?= db_selection.container
			end

			if not keep_connection then
				disconnect
			end
		end

feature -- Iteration

	start is
			-- Set the cursor on first element
		do
			db_selection.start
		end

	forth is
			-- Move cursor to next element
		do
			db_selection.forth
		end

	after: BOOLEAN is
			-- True for the last element
		do
			Result := db_selection.after
		end


	item: DB_TUPLE is
			-- Current element
		do
			Result := create {DB_TUPLE}.copy (db_selection.cursor)
		end

feature {NONE} -- Implementation

	db_application: DATABASE_APPL[ODBC]
		-- Database application
	db_control: DB_CONTROL
		-- Database control
	db_result: DB_RESULT
		-- Database query result
	db_selection: DB_SELECTION
		-- Database selection
	last_query: DATE_TIME
		-- Last time when a query was executed
	keep_connection: BOOLEAN
		-- Keep connection alive?

	connect is
			-- Connect to the database
		require else
			db_control_not_void: db_control /= Void
		do
			db_control.connect
		end

	disconnect is
			-- Disconnect from the database
		require else
			db_control_not_void: db_control /= Void
		do
			db_control.disconnect
		end

	is_connected: BOOLEAN is
			-- True if connected to the database
		require else
			db_control_not_void: db_control /= Void
		do
			Result := db_control.is_connected
		end

feature -- Result

	items : ARRAYED_LIST[DB_RESULT]
		-- Query result

end -- class DATABASE_HANDLER_IMPL


