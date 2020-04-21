module Enumerable
    def my_each
        array = to_a
        if block_given?
            for i in array
                yield(i)
            end
        end
        begin
            
        rescue => exception 
        else
            to_enum
        end
    end

    def my_each_with_index
        array = to_a
        i = 0
        if block_given?
            until i == array.length do
                yield(array[i],i)
                i += 1
            end
        end
        begin
            
        rescue => exception 
        else
            to_enum
        end
    end
    
    def my_select
        # your code here
    end

    def my_all
        # your code here
    end

    def my_any
        # your code here
    end

    def my_none
        # your code here
    end

    def my_count
        # your code here
    end

    def my_map
        # your code here
    end

    def my_inject
        # your code here
    end
end

puts "\n My each_with_index demo"
[1, 2, 3, 4].my_each_with_index do |e,i |
  puts "item: #{e}"
  puts "index: #{i}"
end