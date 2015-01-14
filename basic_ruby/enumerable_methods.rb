require 'pry'

module Enumerable
	def my_each
		return self unless block_given?
		for i in self
			yield(i)
		end
	end

	def my_each_with_index
		i = 0
		while i < self.length
			yield(i, self[i])
			i += 1
		end
	end

	def my_select
		new_array = []
		for i in self
			if yield(i)
				new_array << i
			end
		end

		return new_array
	end

	def my_all?
		if block_given?
			my_each {|i| return false unless yield(i)}
		else
			my_each {|i| return false unless i}
		end
		return true
	end

	def my_any?
		if block_given?
			my_each {|i| return true if yield(i)}
		else
			my_each {|i| return true if i}
		end
		return false
	end

	def my_none?
		if block_given?
			my_each {|i| return false if yield(i)}
		else
			my_each {|i| return false if i}
		end
		return true
	end

	def my_count(num=nil)
		c = 0
		if block_given?
			my_each {|i| c += 1 if yield(i)}
		elsif num.nil?
			c = self.length
		else
			my_each {|i| c += 1 if i == num}
		end
		return c
	end

	def my_map
		new_array = []
		if block_given?
			my_each {|i| new_array << yield(i)}
			return new_array
		else
			return self.to_enum
		end
	end

	def my_inject(initial=nil)
		
		if block_given?
			accumulator	= initial.nil? ? '' : initial		
			for i in self
				accumulator = yield(accumulator, i)
			end
		else
		end
		return accumulator
	end
end

list = ['A','B','C']

#each
list.each{|x| puts x}
puts "---"
list.my_each {|x| puts x}

puts "========"

#each_with_index
list.each_with_index{|index, x| puts "#{index}, #{x}"}
puts "---"
list.each_with_index{|index, x| puts "#{index}, #{x}"}

puts "========"

#select
puts list.select{|x| x == 'A'}
puts "---"
puts list.my_select{|x| x == 'A'}

puts "========"

#all?
puts list.all? {|x| x == 'A'}
puts "---"
puts list.my_all? {|x| x == 'A'}

puts "========"

#any?
puts list.any? {|x| x == 'A'}
puts "---"
puts list.my_any? {|x| x == 'A'}

puts "========"

#none?
puts list.none? {|x| x == 'A'}
puts "---"
puts list.my_none? {|x| x == 'A'}

puts "========"

#count
puts list.count
puts "---"
puts list.my_count

puts "========"

#map
puts list.map {|x| x = (x.ord+1).chr}
puts "---"
puts list.my_map {|x| x = (x.ord+1).chr}

puts "========"

#my_inject
puts list.inject {|combo, element| combo + element}.inspect
puts "---"
puts list.my_inject {|combo, element| combo + element}.inspect