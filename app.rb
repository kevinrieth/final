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
    view "venue"
end

get "/venues/:id/checkins/new" do
    puts "params: #{params}"

    @venue = venues_table.where(id: params[:id]).to_a[0]
    view "new_checkin"
end

get "/venues/:id/checkins/thankyou" do
    puts "params: #{params}"

    view "checkin_thankyou"
end

get "/account/new" do
    view "createaccount"
end