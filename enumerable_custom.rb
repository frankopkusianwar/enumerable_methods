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
            to_enum(:my_each)
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
            to_enum(:my_each_with_index)
        end
    end
    
    def my_select(*)
        if block_given?
            array = []
            my_each do |item|
                if yield(item)
                    array << item
                end
            end
        end
        begin
            
        rescue => exception 
        else
            to_enum(:my_select)
        end
        array
    end

    def my_all?
        if block_given?
            condition = true
            my_each do |item|
                if yield(item) === false
                    condition = false
                end
            end
        end
        begin
            
        rescue => exception 
        else
            to_enum(:my_all?)
        end
        condition
    end

    def my_any?
        if block_given?
            condition = false
            my_each do |item|
                if yield(item) === true
                    condition = true
                end
            end
        end
        begin
            
        rescue => exception 
        else
            to_enum(:my_any?)
        end
        condition
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