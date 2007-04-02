indexing
	description: "User manager (controller)."
	author: "Samuele Lucchini <origo@muele.net>"
	date: "$Date$"
	revision: "$Revision$"

class USER_MANAGER inherit

	SHARED_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
		 		-- Create a user manager
		do
				-- Initialize the cache
			create user_cache.make (0)
		end

feature -- Access

	get_user (a_username: STRING): USER is
				-- Get user with name `a_username' from cache if available
				-- or from database if not already loaded
		require
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
		local
			user: USER
		do
			if user_cache.has (a_username) then
					-- Get user from cache
				user := user_cache.item (a_username)
			else
					-- Load from database and store in cache
				user := database_manager.load_user (a_username)
				if user /= Void then
					user_cache.extend (user, a_username)
				end
			end
			Result := user
		end

	get_user_by_id (an_id: INTEGER): USER is
			-- Get user with the given guid
		local
			user: USER
		do
			user := database_manager.load_user_by_id (an_id)
			if user /= Void then
				-- Use `get_user' in order to make cache consistent
				user := get_user (user.username)
			end
			Result := user
		end

	remove_user (a_user: USER) is
				-- Remove user from system
		require
			user_not_void: a_user /= Void
		do
			if user_cache.has (a_user.username) then
					-- Remove if cached
				user_cache.remove (a_user.username)
			end
				-- Remove from database
			database_manager.delete_user (a_user)
		end

	update_user (a_user: USER) is
				-- Update changes to database
		require
			user_not_void: a_user /= Void
		do
			database_manager.update_user (a_user)
		end

	user_list: ARRAYED_LIST [STRING] is
			-- Return the list of Origo users
		do
			Result := database_manager.load_all_user_names
		end

feature -- Factory

	create_user (a_username: STRING; a_password: STRING; a_first_name: STRING; a_last_name: STRING; an_email: STRING; a_description: STRING):USER is
				-- Create a new user to database and reload it in order to get the right 'guid' value
		require
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
			password_not_void:  a_password /= Void
			first_name_not_void:  a_first_name /= Void
			last_name_not_void: a_last_name  /= Void
			email_not_void: an_email /= Void
			description_not_void: a_description /= Void
		local
			new_user: USER
		do
				-- If `a_username' is already in use then return a Void object
			if get_user (a_username) /= Void then
				new_user := Void
			else
					-- Create user with `guid' equals 0 and then reload it from database with the right ID value
				create new_user.make ("0", a_username, a_password, a_first_name, a_last_name, an_email, a_description)
				database_manager.create_user (new_user)
				new_user := get_user (a_username)
			end

			Result := new_user
		end

feature {NONE} -- Implementation

	user_cache: HASH_TABLE [USER, STRING]
		-- User cache

end -- class USER_MANAGER
