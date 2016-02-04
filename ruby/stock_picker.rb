def stock_picker(price_array)
    max_profit = 0
    buy_index = 0
    sell_index = 0
    min_price_index = 0
    len = price_array.length
    for i in (0...len) do
        if price_array[i] < price_array[min_price_index]
            min_price_index = i
        end
        temp_profit = price_array[i] - price_array[min_price_index]
        if temp_profit > max_profit
            max_profit = temp_profit
            buy_index = min_price_index
            sell_index = i
        end
    end
    return buy_index, sell_index
end
puts "enter the prices as a comma separated string"
price_array = gets.chomp.split(',').map {|ch| ch.to_i }
result = stock_picker(price_array)

