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
  String :imgurl
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

venues_table.insert(title: "Martyrs'", 
                    city: "Chicago",
                    state: "IL",
                    imgurl: "https://cdn.usarestaurants.info/assets/uploads/966c23efcd7ec6bdfdcd3d7471ef1b9f_-united-states-illinois-cook-county-chicago-421871-martyrshtm.jpg")

venues_table.insert(title: "Burlington Bar", 
                    city: "Chicago",
                    state: "IL",
                    imgurl: "https://www.chicagotribune.com/resizer/3TV7GbjJYyr3ByxNS0BpIitEcMU=/1200x0/top/arc-anglerfish-arc2-prod-tronc.s3.amazonaws.com/public/S4S5FGZAFBDNJO3Q7DE2U7L4XA.jpg")

venues_table.insert(title: "Emporium", 
                    city: "Chicago",
                    state: "IL",
                    imgurl: "https://3x8gn64dou5j4drnsu1l66nj-wpengine.netdna-ssl.com/wp-content/uploads/2015/08/home-bg-slides-5.jpg")

venues_table.insert(title: "Mexitaly", 
                    city: "York",
                    state: "PA",
                    imgurl: "https://brewerylocal.com/wp-content/uploads/2019/11/mexitaly-skeleton.jpg")

venues_table.insert(title: "Spirit", 
                    city: "Pittsburgh",
                    state: "PA",
                    imgurl: "https://images.squarespace-cdn.com/content/v1/5500fa72e4b0bce6805d867a/1555684215018-OOU3Q1T15A7921OSVDR1/ke17ZwdGBToddI8pDm48kJwPXV7m4jSdjfwuOULw7T17gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0ktJPZ5nzlpAQ9l-HYKRq6WraCscNT4XZv3Z3uy4d_MdZe0zctX2CvQquGjSqvm_xw/Spirit+front.jpg?format=2500w")

venues_table.insert(title: "Cat's Eye Pub", 
                    city: "Baltimore",
                    state: "MD",
                    imgurl: "https://c8.alamy.com/comp/G3EYR5/cats-eye-pub-emporium-collagia-thames-street-fells-point-baltimore-G3EYR5.jpg")

venues_table.insert(title: "The 8x10", 
                    city: "Chicago",
                    state: "IL",
                    imgurl: "https://www.dcmusicreview.com/wp-content/uploads/2017/10/the8x10-baltimore.jpg")

venues_table.insert(title: "Schubas Tavern", 
                    city: "Chicago",
                    state: "IL",
                    imgurl: "https://s3.amazonaws.com/architecture-org/files/modules/schubas-tavern-eric-rogers-002.jpg")

venues_table.insert(title: "Tin Roof", 
                    city: "Baltimore",
                    state: "MD",
                    imgurl: "https://s3-media0.fl.yelpcdn.com/bphoto/ejPHkVdRe4IGVa9gQHgjeA/o.jpg")
