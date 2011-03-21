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
end
