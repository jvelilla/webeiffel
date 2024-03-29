	indexing
	description: "SELECT query implementation."
	author: "Samuele Lucchini <origo@muele.net>"
	date: "$Date$"
	revision: "$Revision$"

class DAO_DB_QUERY_SELECT_IMPL inherit

	DAO_DB_QUERY_SELECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a selection query
		do
			create conditions.make(2)
			create fields.make(3)
			is_distinct := False;
		end

feature -- Access

	sql: STRING is
			-- SQL query: SELECT [DISTINCT] 'fields' FROM 'table' [WHERE 'conditions']
			-- If 'fields' is emtpty, then select *
		local
			query: STRING
			condition: STRING
		do
			query := "SELECT"
			create condition.make_empty

			if is_distinct then
				query := query + " DISTINCT"
			end

				-- Add table fields
			if not fields.is_empty then
				from
					fields.start
				until
					fields.after
				loop
					query := query + " `" + fields.item.out + "`,"
					fields.forth
				end
					-- Delete last ','
				query.remove_tail (1)
			else
				query := query + " *"
			end

			query := query + " FROM `" + table + "`"

				-- Add conditions if any
			if not conditions.is_empty then
				condition := condition + " WHERE "
				from
					conditions.start
				until
					conditions.after
				loop
					condition := condition + conditions.item + " AND "
					conditions.forth
				end

					-- Remove last ' AND '
				condition.remove_tail(4)

				query := query + condition
			end

			Result := query
		end

feature -- Modifiers

	add_field (a_field: STRING) is
			-- Add table field to SELECT
		do
			fields.extend(a_field)
		end

	add_condition (a_condition: STRING)	is
			-- Add selection condition
		do
			conditions.extend(a_condition)
		end

	set_table (a_table: STRING)	is
			-- set the database table
		do
			table := a_table
		end

	is_distinct: BOOLEAN
		-- Is selection distinct?

end -- class DB_QUERY_SELECT_IMPL
