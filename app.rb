require 'sinatra/base'
require_relative './lib/databasequery'
require_relative './lib/chittermanager'
require 'time'

class Chitter < Sinatra::Base
  get '/home' do
    @chirps = ChitterManager.all
    @time = Time.new
    @preview = params[:content]
    @preview = @preview.strip unless @preview.nil?
    erb :index
  end

  get '/' do 
    DatabaseQuery.setup()
    redirect '/home'
  end

  post '/add-chirp' do 
    ChitterManager.add(params[:content], params[:author], params[:youtube])
    redirect '/home'
  end 

  post '/home' do
    url_add = params[:content].strip
    redirect '/home?content=' + url_add
  end

  run! if app_file == $0
end
