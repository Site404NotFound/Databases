-- Show me the SQL command to create a table with the following properties (you may need to google a thing or two to find the correct syntax):

-- Table name: Airplane [Complete]
-- Attributes:
-- id - auto incrementing integer which is the primary key [Complete]
-- name - variable length string with a max of 255 characters [Complete]
-- liftcapacity - integer, can not be null [Complete]
-- cost - integer [Complete]

CREATE TABLE 'Airplane' (
	'id' int NOT NULL AUTO_INCREMENT,
	'name' varchar (255),
	'liftcapacity' int NOT NULL,
	'cost' int,
	PRIMARY KEY ('id'),
) ENGINE=InnoDB;