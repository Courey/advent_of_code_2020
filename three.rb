class DownhillSki
    @@input = File.readlines('./data_sets/three.txt')

    def initialize
        @cumulative_results = 1
    end

    def testy
        testy_test = SkiSlope.new(@@input, 1,2)
        puts testy_test.count_trees
    end

    def first_test
        test_1 = SkiSlope.new(@@input, 3)
        puts test_1.count_trees
    end

    def second_test
        runs = [[1,1],[3,1],[5,1],[7,1],[1,2]]
        runs.each do |run|
            ski_session = SkiSlope.new(@@input, run[0], run[1])
            count = ski_session.count_trees
            puts count
            @cumulative_results *= count
        end
        puts @cumulative_results
    end

end

class SkiSlope
    def initialize(input, x_increase, y_increase=1)
        @input = input
        @result = 0
        @x_increase = x_increase
        @y_increase = y_increase
        @current_x = 0
    end

    def count_trees
        iteration = 0
        @input.each do |line|
            iteration += 1
            next if @y_increase == 2 && iteration.even?

            check_path(line.chomp,iteration)
            @current_x += @x_increase
        end

        return @result
    end

    def check_path(terrain,y)
        if terrain[@current_x]
            if terrain[@current_x] == '#'
                @result += 1
            end
        else
            extended_terrain = terrain * 2
            check_path(extended_terrain,y)
        end
    end

end


test_1 = DownhillSki.new
test_1.first_test

test_2 = DownhillSki.new
test_2.second_test