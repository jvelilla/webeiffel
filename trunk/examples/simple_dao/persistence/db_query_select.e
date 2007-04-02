indexing
	description: "Abstract SELECT query."
	author: "Samuele Lucchini <origo@muele.net>"
	date: "$Date$"
	revision: "$Revision$"

deferred class DAO_DB_QUERY_SELECT inherit

	DAO_DB_QUERY

feature -- Modifiers

	set_table (a_table: STRING)	is
			-- Table name
		require
			table_not_void: a_table /= Void
			table_not_empty: not a_table.is_empty
		deferred
		end

	add_field (a_field: STRING)	is
			-- Add table fied to SELECT
		require
			field_not_void: a_field /= Void
			field_not_empty: not a_field.is_empty
		deferred
		end

	add_condition (a_condition: STRING)	is
			-- Add selection condition
		require
			condition_not_void: a_condition /= Void
			condition_not_empty: not a_condition.is_empty
		deferred
		end

	is_distinct: BOOLEAN is
			-- Set selection as DISTINCT
		deferred
		end

feature {NONE} -- Implementation

	table: STRING
		-- Table to apply query
	fields: ARRAYED_LIST[STRING]
		-- Selection fileds
	conditions: ARRAYED_LIST[STRING]
		-- Selection conditions

end -- DB_QUERY_SELECT

