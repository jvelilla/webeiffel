indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization
    user_mgr:USER_MANAGER

    make is
			-- Creation procedure.
			local
				new_user:USER
		do
			  create user_mgr.make
			  create_users
              update_users

		end

		create_users is
		    -- Create a list of Users
			do

              print("%N"+ user_mgr.create_user ("javier",   "password", "javier","alvares", "javier@gmail.com","Eiffel Programer").to_string);
			  print("%N"+ user_mgr.create_user ("dave", "password", "dave","gonzales", "dave@gmail.com","Eiffel Programer").to_string);
 			  print("%N"+ user_mgr.create_user ("andy", "password", "andy","fernandez", "andy@gmail.com","Eiffel Programer").to_string);
  			  print("%N"+ user_mgr.create_user ("jhonson", "password", "jhonson","guzman", "jhonson@gmail.com","Eiffel Programer").to_string);
 			  print("%N"+ user_mgr.create_user ("pedro", "password", "pedro","cardozo", "pedro@gmail.com","Eiffel Programer").to_string);
 			  print("%N"+ user_mgr.create_user ("miguel", "password", "miguel","graciani", "miguel@gmail.com","Eiffel Programer").to_string);
 			  print("%N"+ user_mgr.create_user ("luisa", "password", "luisa","musladini", "luisa@gmail.com","Eiffel Programer").to_string);
 			  print("%N"+ user_mgr.create_user ("lara", "password", "lara","bracamonte", "lara@gmail.com","Eiffel Programer").to_string);
              print("%N"+ user_mgr.create_user ("tomas", "password", "tomas","insua", "tomas@gmail.com","Eiffel Programer").to_string);
			end

		 update_users is
		   	--
		   	local
		   	    users:ARRAYED_LIST[STRING]
		   	    user_name:STRING
		   	    user:USER
		   	    id: INTEGER
		   	do
		   		users:=user_mgr.user_list
		   		from
		   			id:=0
		   			users.start
		   		until users.after

		   		loop
		   			user_name:=users.item
		   			user:=user_mgr.get_user (user_name)
		   		    print("%N" + user.to_string)
		   		    user.set_password ("new_password" + id.to_hex_string)
		   		    user_mgr.update_user (user)
		   		    users.forth
		   		    id:=id + 1
		   		end
		   	end

end -- class ROOT_CLASS
