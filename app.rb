class KrokenSlide < Sinatra::Base
	enable :sessions
	configure :production do; DataMapper.setup(:default, ENV['DATABASE_URL']) end

	configure :development do
		DataMapper::Logger.new($stdout, :debug)
		DataMapper.setup(:default, "sqlite://#{Dir.pwd}/dev.db")
	end
	configure :test do 
		require 'dm-migrations'
		DataMapper.setup(:default, "sqlite::memory:")
		DataMapper.auto_migrate!
	end
	configure do; DataMapper.finalize end

	get '/' do
		@items = Item.all.collect{|item|
			{	:namn => haml("%input{:name=>'#{item.name}[name]',:type=>'text', :value=>'#{item.name}',:readonly=>true}"),
				:pris => haml("%input{:name=>'#{item.name}[price]',:type=>'text', :value=>'#{item.price.to_i}kr'}"),
				"ska visas?" => haml("%input{:name=>'#{item.name}[display]',
					:type=>'checkbox',:value=>false}")}
		}
		haml :index
	end
	post '/' do
		session[:display_items] = []
		params.delete_if{|key,value|
			value[:display] != "on" }.each_value{|value|
			session[:display_items] << {:name=>value[:name],:price=>value[:price]}
		}
		redirect '/slide-show'
	end
	get '/slide-show' do
		@items = session[:display_items]
		haml :slide_show
	end
end
