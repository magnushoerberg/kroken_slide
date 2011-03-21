class KrokenSlide < Sinatra::Base

	enable :sessions
	set :root, File.dirname(__FILE__)

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
		event = Event.last
		@event_name = event.name unless event.nil?
		@items = Item.all(:order=>[:type, :price.asc]).collect{|item|
			@name = item.name
			@price = item.price
			@use = event.nil? ? nil : (:checked if event.items.include?(item))
			{	:namn => haml(:item_name_helper, :layout => false),
				:pris => haml(:item_price_helper, :layout => false),
				"ska visas?" => haml(:item_use_helper, :layout => false)
			} 
		}
		haml :index
	end
	post '/' do
		event = Event.first_or_create(:name => params[:event_name])
		event.items.clear
		params.delete_if{|key,value|
			value[:use] != "on" }.each_value{|value|
			event.items << Item.first_or_create(:name=>value[:name],:price=>value[:price])
		}
		event.save
		redirect "/slide-show/#{event.id}"
	end
	get '/slide-show/:id' do
		@items = Event.get(params[:id]).items.all(:order=>[:type, :price.asc])
		haml :slide_show
	end
end
