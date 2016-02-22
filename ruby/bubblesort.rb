def bubble_sort(list)
  size = list.length
  size.times do |k|
    i, swapped = 1, false
    while i < size - k
      if list[i - 1] > list[i]
        list[i - 1], list[i] = list[i], list[i - 1]
        swapped = true
      end
      i += 1
    end
    break if !swapped
  end
  return list
end
res = bubble_sort([4,3,78,2,0,2, 3, 5, 2, 1])
puts 'res is: ', res

def bubble_sort_by(list)
  size = list.length
  size.times do |k|
    i, swapped = 1, false
    while i < size - k
      if yield(list[i - 1], list[i]) > 0
        list[i - 1], list[i] = list[i], list[i - 1]
        swapped = true
      end
      i += 1
    end
    break if !swapped
  end
  return list
end

res1 = bubble_sort_by([4,3,78,2,0,2, 3, 5, 2, 1]) do |left, right|
  left <=> right
end
puts 'another res is: ', res1
