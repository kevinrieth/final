# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :venues do
  primary_key :id
  String :title
  String :city, text: true
  String :state, text: true
end
DB.create_table! :checkins do
  primary_key :id
  foreign_key :venue_id
  Boolean :playedhere
  String :review, text: true
end
DB.create_table! :users do
  primary_key :id
  String :firstname
  String :lastname
  String :email
  String :password
end

# Insert initial (seed) data
venues_table = DB.from(:venues)

venues_table.insert(title: "Martyrs", 
                    city: "Chicago",
                    state: "IL")

venues_table.insert(title: "Burlington Bar", 
                    city: "Chicago",
                    state: "IL")

venues_table.insert(title: "Emporium", 
                    city: "Chicago",
                    state: "IL")

venues_table.insert(title: "Mexitaly", 
                    city: "York",
                    state: "PA")

venues_table.insert(title: "Spirit", 
                    city: "Pittsburgh",
                    state: "PA")

venues_table.insert(title: "Cat's Eye Pub", 
                    city: "Baltimore",
                    state: "MD")

venues_table.insert(title: "The Empty Bottle", 
                    city: "Chicago",
                    state: "IL")

venues_table.insert(title: "Schubas Tavern", 
                    city: "Chicago",
                    state: "IL")

venues_table.insert(title: "Tin Roof", 
                    city: "Baltimore",
                    state: "MD")
