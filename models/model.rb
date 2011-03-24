class Item
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :price, Integer
	property :type, Discriminator
	
	has n, :events, :through => Resource
end


class Beer < Item; end
class Cider < Item; end
class Mat < Item; end

class Event
  include DataMapper::Resource
	property :id, Serial
	property :name, String
	has n, :items, :through => Resource	
end
