indexing
	description: "Abstract Database Query"
	author: "jvelilla"
	date: "$Date$"
	revision: "$Revision$"


deferred class DAO_DB_QUERY

feature -- Access

	sql: STRING is
		-- SQL query
		deferred
		end

end -- class DB_QUERY

