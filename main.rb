     
require 'sinatra'
require 'pg'
require 'pry'
require 'sinatra/reloader'

def run_sql(sql)
  conn = PG.connect(dbname: 'happyhour')
  result = conn.exec(sql)
  conn.close
  return result
end

require_relative 'db_config'
require_relative 'models/weekday'
require_relative 'models/special'

get '/' do
  
    redirect '/happyhour'
end

#lists all the weekdays on the landing page
get '/happyhour' do
  @weekdays = Weekday.all
  erb :index
end

# route to new happy hour special form
get '/happyhour/new' do
  erb :new 
end

# happy hour form
post '/happyhour/special' do
  special = Special.new
  special.monday = params[:monday]
  special.tuesday = params[:tuesday]
  special.wednesday = params[:wednesday]
  special.thursday = params[:thursday]
  special.friday = params[:friday]
  special.saturday = params[:saturday]
  special.sunday = params[:sunday]
  special.venue_name = params[:venue_name]
  special.address = params[:address]
  special.suburb = params[:suburb]
  special.happy_hour_time = params[:happy_hour_time]
  special.description = params[:description]
  special.url = params[:url]
  special.save
  redirect '/happyhour'
end

# route to get to day where user has specified
get '/day/:day' do
  user_specified_day = params[:day]
  @specials = Special.where(user_specified_day => true)
  
  erb :day
end

# route to list particular venues and thier specials
get '/special/:id' do
  @specials = Special.find(params[:id])
  erb :venue_details
end







