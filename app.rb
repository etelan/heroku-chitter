require 'sinatra/base'
require_relative './lib/databasequery'
require_relative './lib/chittermanager'
require 'time'

class Chitter < Sinatra::Base
  get '/home' do
    @chirps = ChitterManager.all
    @time = Time.new
    erb :index
  end

  get '/' do 
    DatabaseQuery.setup()
    redirect '/home'
  end

  post '/add-chirp' do 
    ChitterManager.add(params[:content], params[:author])
    redirect '/home'
  end

  run! if app_file == $0
end
