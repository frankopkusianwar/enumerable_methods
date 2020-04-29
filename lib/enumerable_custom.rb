# rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable
  def my_each
    return enum_for unless block_given?

    i = 0
    array = to_a
    while i < array.length
      yield(array[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    array = to_a
    i = 0
    until i == array.length
      yield(array[i], i)
      i += 1
    end
    self
  end

  def my_select(*)
    return enum_for unless block_given?

    array = []
    my_each { |item| array << item if yield(item) }
    array
  end

  def my_all?(arg = nil)
    condition = true
    if block_given?
      my_each { |item| return false if yield(item) == false }
    elsif arg.is_a?(Regexp)
      my_each { |item| return false if arg.match?(item.to_s) == false }
    elsif arg.is_a?(Class)
      my_each { |item| return false if item.is_a?(arg) == false }
    elsif arg.nil? == false
      my_each { |item| return false if item != arg }
    else
      my_each { |item| return false unless item }
    end
    true
  end

  def my_any?(arg = nil)
    condition = false
    if block_given?
      my_each { |item| condition = true if yield(item) == true }
    elsif arg.is_a?(Class)
      my_each { |item| condition = true if item.is_a?(arg) }
    elsif arg.is_a?(Regexp)
      my_each { |item| condition = true if arg.match?(item.to_s) == true }
    elsif arg.nil? == false
      my_each { |item| condition = true if item == arg }
    else
      my_each { |item| condition = true if item }
    end
    condition
  end

  def my_none?(arg = nil, &proc)
    !my_any?(arg, &proc)
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
      array.my_each { |i| number += 1 if i == args[0] } unless args.empty?
    end
    number
  end

  def my_map(&proc)
    return to_enum(:my_map) unless block_given?

    map = []
    my_each { |item| map << proc.call(item) }
    map
  end

  def my_inject(*args)
    reducer = args[0] if args[0].is_a?(Integer)
    if block_given? && args[0].is_a?(Integer)
      total = args[0]
      my_each { |item| total = yield(total, item) }
      total
    elsif block_given?
      total = 0
      my_each { |item| total = yield(total, item) }
      total
    elsif args[0].is_a?(Symbol)
      my_each { |item| reducer = reducer ? reducer.send(args[0], item) : item }
      reducer
    elsif args[0] && args[1].is_a?(Symbol)
      my_each { |item| reducer = reducer ? reducer.send(args[1], item) : item }
      reducer
    end
  end
end

# rubocop:enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

def multiply_els(array)
  array.my_inject(:*)
end
