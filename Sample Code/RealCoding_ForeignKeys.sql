bsg_people | CREATE TABLE 'bsg_people' (
  'id' int (11) NOT NULL AUTO_INCREMENT,
  'fname' varchar (255) NOT NULL,
  'lname' varchar (255) DEFAULT NULL,
  'homeworld' int(11) DEFAULT NULL,
  'age' int (11) DEFAULT NULL,
  PRIMARY KEY ('id'),
  KEY 'homeworld' ('homeworld'),
  CONSTRAINT 'bsg_cert_people_ibfk_1' FOREIGN KEY ('homeworld') REFERENCES 'bsg_planets' ('id')
  ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1


insert into bsg_people (fname, homeworld) values ('TestPerson', 1);
