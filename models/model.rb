class Item
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :price, Decimal
end
