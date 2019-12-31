def sayhello(msg="no msg")
    puts "hello "+msg;
end

sayhello("world")
sayhello "Ayush"
sayhello

def test1(n)
    (1..n).each do |x|
        puts x
    end
end

#test1(15)

#no return but return
def myfun1(x,y)
    z=x+y
    puts z
end

puts myfun1 10,20