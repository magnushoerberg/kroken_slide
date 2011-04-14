#encoding: utf-8
class Item
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :price, Integer
	property :type, Discriminator

	has n, :events, :through => Resource
end


class Beer < Item
	def sort
		"Öl"
	end
end
class Cider < Item
	def sort
		"Cider"
	end
end
class Mat < Item
	def sort
		"Mat"
	end
end
class Vin < Item
	def sort
		"Vin"
	end
end

class Event
  include DataMapper::Resource
	property :id, Serial
	property :name, String
	has n, :items, :through => Resource	
end
