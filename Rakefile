namespace :db do
	task :environment do
		require 'dm-core'
		require "#{Dir.pwd}/models/model.rb"
		DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/dev.db")
		DataMapper.finalize
	end
	task :migrate => :environment do
		require 'dm-migrations'
		DataMapper.auto_migrate!
	end
	task :seed => :environment do
		40.times{|i|
			if(i < 35)
				Beer.create(:name => "öl#{i}", :price => rand(100))
			else
				Cider.create(:name => "cider#{i}", :price => rand(100))
			end
		}
	end
  task :parse_csv => :environment do
    require 'csv'
    puts "Adding..."
    CSV.open('ol.csv','r',',') do |row|
      name,price=row
      price = (price.match(/\d*.\d*/).to_s.to_f/0.65).ceil unless price.nil?
      puts name
      puts price
      Beer.first_or_create(:name => name.capitalize).update(:price => price)
    end
    CSV.open('cider.csv','r',',') do |row|
      name,price=row
      price = (price.match(/\d*.\d*/).to_s.to_f/0.65).ceil unless price.nil?
      puts name
      puts price
      Cider.first_or_create(:name => name.capitalize).update(:price => price)
    end
  end
end
