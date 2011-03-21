class Item
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :price, Float
	property :type, Discriminator
	
	belongs_to :event
end


class Beer < Item; end
class Cider < Item; end

class Event
  include DataMapper::Resource
	property :id, Serial
	has n, :items
end
