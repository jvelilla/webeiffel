indexing
	description: "Database configuration"
	author: "jvelilla"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DAO_DATABASE_CONFIG

feature -- Database access

	Db_config_hostname: STRING is "localhost"
		-- Database hostname

	Db_config_username: STRING is "root"
		-- Database username

	Db_config_password: STRING is ""
		-- Database password

	Db_config_database_name: STRING is "security"
		-- Database name

	Db_config_keep_connection: BOOLEAN is
			-- Keep connection to database?
		do
			Result := False
		end


feature -- Database table 'user'

	Db_config_table_security_user: STRING is "user"
			-- Table name
	Db_config_table_security_user_id: STRING is "id"
			-- Table field
	Db_config_table_security_user_username: STRING is "username"
			-- Table field
	Db_config_table_security_user_password: STRING is "password"
			-- Table field
	Db_config_table_security_user_firstname: STRING is "firstname"
			-- Table field
	Db_config_table_security_user_lastname: STRING is "lastname"
			-- Table field
	Db_config_table_security_user_email: STRING is "email"
			-- Table field
	Db_config_table_security_user_description: STRING is "description"
			-- Table field

end
