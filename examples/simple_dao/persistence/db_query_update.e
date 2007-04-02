indexing
	description: "Abstract INSERT query."
	author: "Samuele Lucchini <origo@muele.net>"
	date: "$Date$"
	revision: "$Revision$"

deferred class DAO_DB_QUERY_UPDATE inherit

	DAO_DB_QUERY

feature -- Modifiers

	set_table (a_table: STRING) is
			-- Table name
		require
			table_not_void: a_table /= Void
			table_not_empty: not a_table.is_empty
			deferred
		end

	add_field (a_field: STRING; a_value: STRING) is
			-- Add table fied to INSERT
		require
			field_not_void: a_field /= Void
			field_not_empty: not a_field.is_empty
			value_not_void: a_value /= Void
		deferred
		end

	add_condition (a_condition: STRING)	is
			-- Add selection condition
		require
			condition_not_void: a_condition /= Void
			condition_not_empty: not a_condition.is_empty
		deferred
		end

feature {NONE} -- Implementation

	table: STRING
		-- Table where the query applies to
	fields: ARRAYED_LIST[TUPLE[STRING, STRING]]
		-- Fields to update
	conditions: ARRAYED_LIST[STRING]
		-- Conditions for update

end -- class DB_QUERY_UPDATE

