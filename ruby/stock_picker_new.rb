def stock_picker(price_array)
    max_profit = 0
    buy_price = 0
    sell_price = 0
    min_price = price_array[0]
    len = price_array.length
    price_array.each do |price|
        if price < min_price
            min_price = price
        end
        temp_profit = price - min_price
        if temp_profit > max_profit
            max_profit = temp_profit
            buy_price = min_price
            sell_price = price
        end
    end
    return price_array.index(buy_price), price_array.index(sell_price)
end
puts "enter the prices as a comma separated string"
price_array = gets.chomp.split(',').map {|ch| ch.to_i }
result = stock_picker(price_array)

