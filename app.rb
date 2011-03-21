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
		@items = Item.all(:order=>[:type, :price.asc]).collect{|item|
			{	:namn => haml("%input{:name=>'#{item.name}[name]',:type=>'text', :value=>'#{item.name}',:readonly=>true}"),
				:pris => haml("%input{:name=>'#{item.name}[price]',:type=>'text', :value=>'#{item.price.to_i}kr'}"),
				"ska visas?" => haml("%input{:name=>'#{item.name}[display]',
					:type=>'checkbox', :checked=>'true'}")}
		}
		haml :index
	end
	post '/' do
		event = Event.first_or_create(:name => params[:name])
		puts params[:'value[:display]']
		params.delete_if{|key,value|
			value[:display] != "on" }.each_value{|value|
		  event.items << Item.first_or_create(:name=>value[:name],:price=>value[:price])
		}
		redirect "/slide-show/#{event.id}"
	end
	get '/slide-show/:id' do
		@items = Item.all(:event_id => params[:id], :order => [:type, :price.asc])
		haml :slide_show
	end
end
