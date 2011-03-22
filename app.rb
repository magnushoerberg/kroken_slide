# encoding: UTF-8
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
		redirect '/new/event' if event.nil?
		@event = {:name => event.name, :id => event.id}
		@items = Event.last.items
		haml :index
	end
	get '/new/event' do
		haml :new_event
	end
	post '/new/event' do
		Event.create(:name => params[:name])
		redirect '/'
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
	post '/remove/item' do
		event_item = EventItem.first(:item_id => params[:item_id],
																 :event_id => params[:event_id])
		event_item.destroy
	end
	post '/add/item' do
		item = case params[:type]
		when "Öl" then
						Beer.first_or_create(:name=>params[:item_name])
		when "Cider" then
						Cider.first_or_create(:name=>params[:item_name])
		end
		item.update(:price => params[:item_price])
		event = Event.get(params[:event_id])
		event.items << item
		event.save
		haml(:item_partial, :locals=>{:item => item})
	end
	get '/slide-show/:id' do
		@items = Event.get(params[:id]).items.all(:order=>[:type, :price.asc])
		haml(:slide_show)
	end
	get "/item/all" do
		items = Item.all(:name.like => "%#{params[:search_name]}%".capitalize,
										 :fields => [:name,:price]).collect{|item|
			{:name => item.name,
			:price => item.price}
		}
		items.to_json
	end
end
