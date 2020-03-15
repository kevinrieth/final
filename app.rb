# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "bcrypt"  
require "geocoder"                                                                   #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

venues_table = DB.from(:venues)
checkins_table = DB.from(:checkins)
users_table = DB.from(:users)

get "/" do
    puts "params: #{params}"

    pp venues_table.all.to_a
    @venues = venues_table.all.to_a
    view "venues"
end

get "/venues/:id" do
    puts "params: #{params}"

    @venue = venues_table.where(id: params[:id]).to_a[0]
    @checkins = checkins_table.where(venue_id: @venue[:id]).to_a
    @users_table = users_table
    @lat = @venue[:latitude]
    @long = @venue[:longitude]
    @lat_long = "#{@lat},#{@long}"
    pp @lat_long
    view "venue"
end

get "/venues/:id/checkins/new" do
    puts "params: #{params}"
    @venue = venues_table.where(id: params[:id]).to_a[0]
    view "new_checkin"
end

get "/venues/:id/checkins/thankyou" do
    puts params
    @venue = venues_table.where(id: params["id"]).to_a[0]
    checkins_table.insert(venue_id: params["id"],
                       user_id: session["user_id"],
                       playedhere: params["playedhere"],
                       review: params["review"])
    view "checkin_thankyou"
end

get "/user/new" do
    view "new_user"
end

post "/users/create" do
    puts params
    hashed_password = BCrypt::Password.create(params["password"])
    users_table.insert(firstname: params["firstname"], lastname: params["lastname"], email: params["email"], password: hashed_password)
    view "account_thankyou"
end

get "/logins/new" do
    view "new_login_session"
end

post "/logins/create" do
    user = users_table.where(email: params["email"]).to_a[0]
    puts BCrypt::Password::new(user[:password])
    if user && BCrypt::Password::new(user[:password]) == params["password"]
        session["user_id"] = user[:id]
        @current_user = user
        view "create_login"
    else
        view "create_login_nope"
    end
end