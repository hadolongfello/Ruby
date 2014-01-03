require 'support/number_helper'
class Car

	@@filepath = nil
	
	def self.filepath=(path)
		@@filepath = File.join(APP_ROOT, path)
	end
	
	attr_accessor :name, :model, :make, :year, :color
	
	def self.file_exists?
		# class should know if car file exist
		if @@filepath && File.exists?(@@filepath)
			return true
		else
			return false
		end
	end
	
	def self.file_usable?
		return false unless @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true
	end
	
	def self.create_file
		#create the car file
		File.open('@@filepath','w') unless file_exists?
		return file_usable?
	end
	
	def self.saved_car
		# read the car file
		# return instances of car
		car = []
		if file_usable?
			file = File.new(@@filepath, 'r')
			file.each_line do |line|
				car << Car.new.import_line(line.chomp) 
			end
			file.close
		end
		return car
	end
	
	def self.build_using_questions
	
		args = {}
		print "Car name: "
		args[:name] = gets.chomp.strip
		print "Car model: "
		args[:model] = gets.chomp.strip
		print "Car make: "
		args[:make] = gets.chomp.strip
		print "Car year: "
		args[:year] = gets.chomp.strip
		print "Car color: "
		args[:color] = gets.chomp.strip
		
		return self.new(args)
		
	end
	
	def initialize(args={})
		@name = args[:name] || ""
		@model = args[:model] || ""
		@make = args[:make] || ""
		@year = args[:year] || ""
		@color = args[:color] || ""
	end
	
	def import_line(line)
		line_array = line.split("\t")
		@name, @model, @make, @year, @color = line_array
		return self
	end
	
	#def formatted_price
	#	number_to_currency(@year)
	#end
	
	def save
		return false unless Car.file_usable?
		File.open(@@filepath, 'a') do |file|
			file.puts "#{[@name, @model, @make, @year, @color].join("\t")}\n"			
		end
		return true
	end
end