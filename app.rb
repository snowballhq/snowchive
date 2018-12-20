require 'sinatra'
require 'csv'

get '/' do
  'Change the URL to /users/:username/clips'
end

get '/users/:username/clips' do
  user_rows = []
  CSV.foreach('data.csv', headers: true) do |row|
    user_rows << row if row[1].downcase == params[:username].downcase
  end
  @clip_urls = user_rows.map { |row| row[2] }
  erb :clips
end
