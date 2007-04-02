indexing
	description: "Global shared managers (controllers)."
	author: "jvelilla"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_MANAGER

feature -- Access


	database_manager: DAO_DATABASE_MANAGER is
			-- Database manager
		once
			create Result.make
		end


end -- class SHARED_MANAGER
