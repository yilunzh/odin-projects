def stock_picker(prices)
	max_diff = 0
	for i in 0...prices.length
		for j in i...prices.length
			diff = prices[j] - prices[i]
			if diff > max_diff
				max_diff = diff
				max_index = [i, j]
			end
		end
	end
	return max_index
end

puts stock_picker([17,3,6,9,15,8,6,1,10])
