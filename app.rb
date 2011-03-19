class KrokenSlide < Sinatra::Base

	configure :production do; DataMapper.setup(:default, ENV['DATABASE_URL']) end

	configure :development do
		DataMapper::Logger.new($stdout, :debug)
		DataMapper.setup(:default, "sqlite://#{Dir.pwd}/dev.db")
	end
	configure :test do 
		DataMapper.setup(:default, "sqlite::memory:")
	end
	configure do; DataMapper.finalize end

	get '/' do; haml :index end
end
