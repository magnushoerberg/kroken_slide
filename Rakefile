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
		Item.create(:name => "test1", :price=>20)
		Item.create(:name => "test2", :price=>25)
		Item.create(:name => "test3", :price=>20)
	end
end
