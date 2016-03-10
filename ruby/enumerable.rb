module Enumerable
  def my_each
    i, len = 0, self.length
    while i < len
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i, len = 0, self.length
    while i < len
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    i, len = 0, self.length
    temp_arr = []
    while i < len
      if yield(self[i])
        temp_arr.push(self[i])
      end
      i += 1
    end
    temp_arr
  end

  def my_all?
    i, len = 0, self.length
    passed = true
    while i < len
      if !yield(self[i])
        passed = false
      end
      i += 1
    end
    puts passed
  end

  def my_any?
    i, len = 0, self.length
    passed = false
    while i < len
      if yield(self[i])
        passed = true
      end
      i += 1
    end
    puts passed
  end

  def my_none?
    i, len = 0, self.length
    passed = true
    while i < len
      if yield(self[i])
        passed = false
      end
      i += 1
    end
    puts passed
  end

  def my_count
    i, len, counter = 0, self.length, 0
    while i < len
      temp = yield(self[i])
      if yield(self[i])
        counter += 1
      end
      i += 1
    end
    counter
  end

  def my_map(&proc)
    i, len = 0, self.length
    if proc  
      while i < len
        self[i] = proc.call(self[i])
        self[i] = yield(self[i])
        i += 1
      end
  end

  def my_inject(memo = nil)
    i, len = 1, self.length
    memo ||= self[0]
    while i < len
      memo = yield(memo, self[i])
      i += 1
    end
    puts memo
  end

end

def multiply_els(arr)
  arr.my_inject { |mul, n| mul * n}
end

arr = [3, 2, 4, 5, 1]
arr.my_each {|x| puts x}
puts "========================="

arr.my_each_with_index { |x, i| puts "item:#{x} and index:#{i}"}
puts "========================="

selected = arr.my_select {|x| x > 2}
puts "the selected items are: #{selected}"
puts "========================="

arr.my_all? {|x| x > 1}
puts "========================="

arr.my_any? {|x| x > 1}
puts "========================="

arr.my_none? {|x| x < 1}
puts "========================="

num = arr.my_count {|x| x % 2 == 0}
puts "the count is: #{num}"
puts "========================="

arr.my_map { |x| x + 1}
puts "the array is #{arr}"
p arr
puts "========================="

arr.my_inject { |sum, n| sum + n }
puts "========================="
multiply_els([2,4,5])

proc_a = Proc.new {|x| x > 1}
arr.my_map2(&proc_a)
puts "the array is: "
p arr
