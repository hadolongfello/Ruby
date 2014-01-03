require 'car'
class Guide
	class Config
		@@actions = ['list', 'find', 'add', 'quit']
		def self.actions; @@actions; end
	end
	
	def initialize(path=nil)
		# locate the car text file at path
		Car.filepath = path
		if Car.file_usable?
			puts "Found Car file"
		
		# or create a new file
		elsif Car.create_file
			puts "Created Car file"
		
		# exit if create fails
		else
			puts "Exiting"
			exit!
		end	
	end
	
	def launch!
		introduction
		#action loop
		result = nil
		until result == :quit
			# what you want to do?
			action, args = get_action
			result = do_action(action, args)
		end
		conclusion
	end
	
	def introduction
		puts "\n\n<<< Welcome to the Car Finder >>>\n\n"
		puts "This is an interactive guide to help you find the car you crave.\n\n"
	end
	
	def get_action
		action = nil
		until Guide::Config.actions.include?(action)
		puts "Actions: " + Guide::Config.actions.join(", ") if action
			print "> "
			user_response = gets.chomp
			args = user_response.downcase.strip.split(' ')
			action = args.shift
			
		end
		return action, args
	end
	
	def do_action(action, args=[])
		case action
		when 'list'
			list
		when 'find'
			keyword = args.shift
			find(keyword)
		when 'add'
			add
		when 'quit'
			return :quit
		else
			puts "\nIdon't understand that command.\n"
		end
	end
	
	def list
		puts "\nListing Cars\n\n".upcase
		car = Car.saved_car
		car.each do |carr|
			puts carr.name + " | " + carr.model + " | " + carr.make + " | " + carr.year + " | " + carr.color
		end
	end
	
	def add
		puts "\nAdd a Car\n\n".upcase
		car = Car.build_using_questions
		
		if car.save		
			puts "\n Car Added\n"
		else
			puts "\n ERROR: Car Not Added\n"
		end
	end
	
	def find(keyword="")
		#output_action_header("Find a Car")
		#if keyword
		#	car = Car.saved_car
		#	found = car.select do |carr|
		#		carr.name.downcase.include?(keyword.downcase) ||
		#		carr.model.downcase.include?(keyword.downcase) ||
		#		carr.make.downcase.include?(keyword.downcase) ||
		#		carr.year.downcase.include?(keyword.downcase) ||
		#		carr.color.downcase.include?(keyword.downcase) ||
		#	end	
			#output_car_table(found)
		#else
		# puts "Find using a key phrase to search the cars"
		# puts "Example: 'find volvo'\n\n"
		#end
	end
	
	def conclusion
		puts "\n<<< VROOM! VROOM! COOL CAR!"
	end
	
	private
	
	def output_action_header(text)
		puts "\n#{text.upcase.center(60)}\n\n"
	end
	
	def output_car_table(car=[])
		print " " + "Name".ljust(30)
		print " " + "Model".ljust(20)
		print " " + "Make".ljust(10)
		print " " + "Year".rjust(30)
		print " " + "Color".rjust(20)
		puts "-" *60
		car.each do |carr|
			line = " " << carr.name.ljust(30)
			line << " " + carr.model.ljust(20)
			line << " " + carr.make.ljust(10)
			line << " " + carr.year.rjust(30)
			line << " " + carr.color.rjust(20)
			puts line
		end
		puts "No listings found" if car.empty?
		puts "-" * 60
	end
	
	
end