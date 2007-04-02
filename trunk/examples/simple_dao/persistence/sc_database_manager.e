indexing
	description: "Database manager (controller)."
	author: "Samuele Lucchini <origo@muele.net>"
	date: "$Date$"
	revision: "$Revision$"

class DAO_DATABASE_MANAGER inherit

	SHARED_MANAGER

	DAO_DATABASE_CONFIG

	SQL_USER


create
	make

feature {NONE} -- Initialization

	make is
			-- Creation feature		
		do
		end


feature -- user management

	delete_user (a_user: USER) is
			-- Delete user from database
		require
			user_not_void: a_user /= Void
		local
			db_handler: DATABASE_HANDLER_IMPL
		do
			create db_handler.make_common
			db_handler.set_query (query_user_delete (a_user))
			db_handler.execute_query
		end

	load_user_by_id (an_id: INTEGER): USER
		-- Load user from database
		local
			db_handler: DATABASE_HANDLER_IMPL
			user: USER
			id: STRING
			username: STRING
			password: STRING
			firstname: STRING
			lastname: STRING
			email: STRING
			description: STRING
		do
			create db_handler.make_common
			db_handler.set_query (query_user_select_by_id (an_id))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				create id.make_from_string (db_handler.item.item (1).out)
				create username.make_from_string (db_handler.item.item (2).out)
				create password.make_from_string (db_handler.item.item (3).out)
				create firstname.make_from_string (db_handler.item.item (4).out)
				create lastname.make_from_string (db_handler.item.item (5).out)
				create email.make_from_string (db_handler.item.item (6).out)
				create description.make_from_string (db_handler.item.item (7).out)

				create user.make (id, username, password, firstname, lastname, email, description)
			end

			Result := user
		end

	load_user (a_username: STRING): USER is
			-- Load user from database
		require
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
		local
			db_handler: DATABASE_HANDLER_IMPL
			user: USER
			id: STRING
			username: STRING
			password: STRING
			firstname: STRING
			lastname: STRING
			email: STRING
			description: STRING
		do
			create db_handler.make_common
			db_handler.set_query (query_user_select (a_username))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				create id.make_from_string (db_handler.item.item (1).out)
				create username.make_from_string (db_handler.item.item (2).out)
				create password.make_from_string (db_handler.item.item (3).out)
				create firstname.make_from_string (db_handler.item.item (4).out)
				create lastname.make_from_string (db_handler.item.item (5).out)
				create email.make_from_string (db_handler.item.item (6).out)
				create description.make_from_string (db_handler.item.item (7).out)

				create user.make (id, username, password,  firstname, lastname, email, description)
			else
				user := Void
			end

			Result := user
		end

	load_all_user_names: ARRAYED_LIST [STRING]
		-- Load all user names from database
		local
			db_handler: DATABASE_HANDLER_IMPL
			id: STRING
			name: STRING
		do
			create db_handler.make_common
			db_handler.set_query (query_user_select_all)
			db_handler.execute_query

				-- Build list
			create Result.make (0)
			from
				db_handler.start
			until
				db_handler.after
			loop
				create id.make_from_string (db_handler.item.item (1).out)
				create name.make_from_string (db_handler.item.item (2).out)
				Result.extend (name)
				db_handler.forth
			end
		end

	update_user (a_user: USER) is
			-- Update user's values to database
		require
			user_not_void: a_user /= Void
		local
			db_handler: DATABASE_HANDLER_IMPL
		do
			create db_handler.make_common
			db_handler.set_query (query_user_update (a_user))
			db_handler.execute_query
		end

	create_user (a_user: USER) is
			-- Create a user to database
		require
			user_not_void: a_user /= Void
		local
			db_handler: DATABASE_HANDLER_IMPL
		do
			create db_handler.make_common
			db_handler.set_query (query_user_insert (a_user))
			db_handler.execute_query
		end

end -- class DATABASE_MANAGER
