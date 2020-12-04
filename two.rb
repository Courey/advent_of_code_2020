class ValidatePassword
    def initialize(input, test_version)
        @input = input
        @test_version = test_version
        @result = []
    end

    def format_data(entry)
        split_data = entry.split(' ')
        rule = split_data[0].split('-')

        return {
            min: rule[0].to_i,
            max: rule[1].to_i,
            letter: split_data[1].gsub(':', ''),
            password: split_data[2]
        }
    end

    def validate_data
        @input.each do |password_data|
            formatted_data = format_data(password_data)
            if valid?(formatted_data)
                @result<<(formatted_data[:password])
            end
        end
        puts @result.length
    end

    def valid?(data)
        letter = data[:letter]

        if @test_version == 1
            count = data[:password].count letter

            return (count >= data[:min]) && (count <= data[:max])
        end

        if @test_version == 2
            min_char = data[:password][data[:min] - 1]
            max_char = data[:password][data[:max] - 1]

            both = (min_char == letter) && (max_char == letter)
            either = (min_char == letter) || (max_char == letter)

            return (!both && either)
        end
    end

end

input = input = File.readlines('./data_sets/two.txt')

challenge_1 = ValidatePassword.new(input, 1)
challenge_1.validate_data

challenge_2 = ValidatePassword.new(input, 2)
challenge_2.validate_data
