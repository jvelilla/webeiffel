indexing
	description: "Abstract Database Handler"
	author: "jvelilla"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DAO_DATABASE_HANDLER



feature -- Access

	query: DAO_DB_QUERY
			-- Database query to handle

feature -- Modifiers

	set_query (a_query : DAO_DB_QUERY) is
			-- Set query to execute
		require
				query_not_void: a_query /= Void
		do
			query := a_query
		ensure
			query = a_query
		end

feature -- Functionality

	execute_query is
			-- Execute query
		require
			query_not_void: query /= void
		deferred
		end

feature -- Iteration

	start is
			-- Set the cursor on first element
		deferred
		end

	forth is
			-- Move cursor to next element
		deferred
		end

	after: BOOLEAN is
			-- True for the last element
		deferred
		end

	item: ANY is
			-- Current element
		deferred
		end

feature {NONE} -- Implementation

	connect is
			-- Connect to the database
		deferred
		ensure
			is_connected
		end

	disconnect is
			-- Disconnect from the database
		deferred
		ensure
			not_connected: not is_connected
		end

	is_connected: BOOLEAN is
			-- True if connected to the database
		deferred
		end

end
