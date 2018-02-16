class Stack
  def initialize
    @stack = []
  end

  attr_accessor :stack

  def add(el)
    stack << el unless stack.include?(el)
  end

  def remove
    stack.pop
  end

  def show
    stack
  end
end

class Queue
  def initialize
    @arr = []
  end

  attr_accessor :arr

  def enqueue(el)
      arr << el unless arr.include?(el)
  end

  def dequeue
    arr.shift
  end

  def show
    arr
  end
end

class Map
  def initialize
    @arr = []
  end

  attr_accessor :arr

  def assign(key, value)
      if arr.none?{|x| x.first == key}
        arr << [key, value]
      else
        self.remove(key)
        arr << [key,value]
      end
  end

  def look_up(key)
    arr.each{|x| return x if x.first == key}
  end

  def remove(key)
    arr.reject!{|x| x.first == key}
  end

  def show
    arr
  end
end
