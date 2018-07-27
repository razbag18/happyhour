     
require 'sinatra'
require 'pg'
require 'pry'
# require 'sinatra/reloader'

def run_sql(sql)
  conn = PG.connect(dbname: 'happyhour')
  result = conn.exec(sql)
  conn.close
  return result
end

require_relative 'db_config'
require_relative 'models/weekday'
require_relative 'models/special'
require_relative 'models/user'
require_relative 'models/comment'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
  # if theres a current user, then return true, otherwise if not, return false
  def logged_in? 
    # !!current_user either returning true or false without if statement
    if current_user #forcing current_user user object: true, or nil: false
      true
    else
      false
    end
  end

end

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
  redirect '/' unless logged_in? 

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
  special.user_id = current_user.id
  special.save
  redirect '/happyhour'

end

# route to get to day where user has specified
get '/day/:day' do
  @user_specified_day = params[:day]
  @specials = Special.where(@user_specified_day => true).order(:suburb)
  @weekdays = Weekday.all
  erb :day
end

# route to edit a special
get '/special/:id/edit' do
  redirect '/' unless logged_in? #single line if statement
  @specials = Special.find(params[:id])
  erb :edit
end

put '/special/:id' do
  # raise params.inspect
  special = Special.find(params[:id])

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

  redirect "/special/#{ params[:id] }"
end

# route to list particular venues and their specials
get '/special/:id' do
  @special = Special.find(params[:id])
  @comments = @special.comments
  @random_img = ['cheers.jpg', 'fruit.jpg', 'beer-cheers.jpg', 'beer-collection.jpg', 'wine.jpg', 'neon.jpg', 'champagne-close.jpg', 'beers-top.jpg', 'cocktail-close.jpg'].sample
  erb :venue_details
end

post '/comments' do
  redirect '/' unless logged_in? #single line if statement

  comment = Comment.new
  comment.content = params[:content]
  comment.special_id = params[:special_id]
  comment.user_id = current_user.id
  comment.save
  redirect "/special/#{ params[:special_id] }"
end

get '/register' do
  @weekdays = Weekday.all
  erb :register
end

post '/register' do
  user = User.new
  user.user_name = params[:user_name]
  user.email = params[:email]
  user.password = params[:password]
  user.save
  redirect '/'
end

# get '/login' do
#   erb :login
# end

post '/session' do
  # grab email and password
  # find the user by email
  user = User.find_by(user_name: params[:user_name])
  # authenticate user with password
  if user && user.authenticate(params[:password])
    #showing who is logged in
    session[:user_id] = user.id
    redirect '/'
    # create new session
    # redirect to secret page
  else
    redirect '/'
    # erb :index
  end
end

delete '/session' do
  # end the session
  session[:user_id] = nil    # redirect to login becuase we are doing a destructive operation. want to direct to a safe page, a get page
  redirect '/'
end








