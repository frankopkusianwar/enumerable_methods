module Enumerable
  def my_each
    array = to_a
    if block_given?
      array.each do |i|
        yield(i)
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    array = to_a
    i = 0
    if block_given?
      until i == array.length
        yield(array[i], i)
        i += 1
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select(*)
    if block_given?
      array = []
      my_each do |item|
        array << item if yield(item)
      end
    else
      to_enum(:my_select)
    end
    array
  end

  def my_all?
    if block_given?
      condition = true
      my_each do |item|
        condition = false if yield(item) == false
      end
    else
      to_enum(:my_all?)
    end
    condition
  end

  def my_any?
    if block_given?
      condition = false
      my_each do |item|
        condition = true if yield(item) == true
      end
    else
      to_enum(:my_any?)
    end
    condition
  end

  def my_none?
    condition = true
    my_each do |item|
      condition = false if yield(item)
    end
    condition
  end

  def my_count(*args)
    array = is_a?(Range) ? to_a : self
    return array.length if !block_given? && args.empty?

    number = 0
    if block_given?
      num_elements = []
      array.my_each do |item|
        if yield(item)
          num_elements << item
          number = num_elements.length
        end
      end
    else
      array.my_each do |item|
        unless args.empty?
          number += 1 if item == args[0]
          end
      end
    end
    number
  end

  def my_map
    if block_given?
      map = []
      if proc
        my_each do |item|
          map << proc.call(item)
        end
      else
        map << yield(item)
      end
    else
      to_enum(:my_map)
    end
  end

  def my_inject(start = nil)
    reducer = start if start.is_a?(Integer)
    if block_given?
      start = self[0] if start.nil?
      sum = start
      my_each do |item|
        sum = yield(sum, item)
      end
      sum
    else
      if start.is_a?(Symbol)
        my_each { |item| reducer = reducer ? reducer.send(start, item) : item }
      end
      reducer
    end
  end
end
