def caesar_cypher(string, offset)
	new_string = ''
	offset = offset % 26

	for element in string.split('')
		element_num = element.ord
		new_element = element
		if element_num.between?(65,90)
			new_element = element_num + offset
			if new_element > 90
				new_element -= 26
			elsif new_element < 65
				new_element += 26
			end
		elsif element_num.between?(97,122)
			new_element = element_num + offset
			if new_element > 122
				new_element -= 26
			elsif new_element < 97
				new_element += 26
			end
		end
		new_string += new_element.chr
	end

	return new_string
end

puts caesar_cypher("What a string!", 5)