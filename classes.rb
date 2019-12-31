class Book
    def initialize

    end
    def initialize(aName)
        @name = aName
    end
    def name=(aName)
        @name=aName  #pre declaration of attribute is not reqd, @- prefix means attribute,@@- prefix means static
    end
    def get_name
        return @name
    end
end


#book1=Book.new
#book1.set_name('Wind mills of god')   #Note:- () is optional

#puts book1.get_name


book2 = Book.new("Da vinci code") #constructor
book2.name='ja Vinci Code'
puts book2.get_name


