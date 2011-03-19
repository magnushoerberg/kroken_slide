class KrokenSlide < Sinatra::Base
	get '/' do
		haml :index
	end
end
