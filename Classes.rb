# def sayHello(n) 
# 	#puts message + ", Welcome to Ruby! "+msg2
# 	(1 .. n).each do |x|
# 		puts x
# 	end
# end

# sayHello(10)


# class Book

# 	def set_name(name)
# 		@name = name
# 	end

# 	def get_name
# 		return @name
# 	end
# end

# book1 = Book.new
# book1.set_name("Wings of fire")
# puts book1.get_name


#################################
#		Constructor 			#
#################################

class Book

	def initialize(name)
		@name = name
	end

	def set_name(name)
		@name = name
	end

	def get_name
		return @name
	end
end


book2 = Book.new("Wings of Fire - An Autobiography")
puts book2.get_name