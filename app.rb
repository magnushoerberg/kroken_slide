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

	get '/' do
		@items = Item.all.collect{|item|
			{	:namn => haml("%input{:name=>'#{item.name}[name]',type=>'text', :value=>'#{item.name}'}"),
				:pris => haml("%input{:name=>'#{item.name}[name]',type=>'text', :value=>'#{item.price.to_i}'}"),
				"ska visas?" => haml("%input{:name=>'#{item.name}[display]',
					:type=>'checkbox',:value=>false}")}
		}
		haml :index
	end
	post '/' do
		@display_items = params
		redirect '/slide-show'
	end
	get '/slide-show' do
		@display_items.inspect
	end
end
