require 'byebug'

get '/' do
	@urls = Url.all

	@all_url = Url.all.order(click_count: :desc).limit(10)
	erb :"static/index"
end

post '/urls' do
	@url = Url.new(long_url: params[:long_url])
	@url.short_url = @url.shorten
	#byebug
	if @url.save 
		redirect '/'
		#return @url.to_json  #transfer data from web to backend
	else
		@urls = Url.all
		@failed = true

		erb :"static/index" 
	end
end

get '/urls' do
	redirect '/'
end

get '/all-links' do
  @links = Url.pluck(:id, :short_url, :long_url)

  @links.to_json
end


get '/:short_url' do
	url = Url.find_by(short_url: params[:short_url])
		url.counter

		redirect "#{url.long_url}"
end

