require "sinatra"
require "pry" if development? || test?
require "sinatra/reloader" if development?
require "csv"

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  redirect '/articles'
end

get '/articles' do
  @articles = []
  CSV.foreach("articles.csv", headers: true) do |row|
    @articles << row.to_hash
  end
  erb :index
end

get '/articles/new' do
  erb :new
end

post "/articles" do
  title = params["title"]
  url = params["url"]
  description = params["description"]
  if title.strip.empty? || url.strip.empty? || description.strip.empty?
    erb :new
  else
    CSV.open("articles.csv", "a") do |csv_file|
      csv_file << [title, url, description]
    end
    redirect "/articles"
  end

end

get "/random" do
  erb :random
end

get "/random_article.json" do
  status 200
  content_type :json
  random_articles = []

  CSV.foreach("articles.csv", headers: true) do |row|
    random_articles << row.to_hash
  end

  @random_article = random_articles.sample

  @random_article.to_json
end
