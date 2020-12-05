class Validator
    @@input = File.readlines('./data_sets/four.txt')
    @@result = 0

    def initialize
        @valid = []
    end

    def validate_records
        record = []
        @@input.each do |line|
            line = line.gsub(/[\r\n]+/m, '')
            if line.length > 2
                record = record + line.split
            else
                individual_record = Record.new(record)
                if individual_record.valid?
                    @@result += 1
                end

                record = []
            end
        end
        puts @@result
    end
end

class Record
    def initialize(data)
        @data = data
        @fields = []
        @hashed_data = {}
        @valid = true
        allocate_data
    end

    def allocate_data
        @data.each do |field|
            field = field.split(':')
            @fields<<field[0]
            @hashed_data[field[0]] = field[1]
        end
    end

    def valid?
        valid_fields?
        valid_values?
        return @valid
    end

    def valid_fields?
        required_values = ['hcl', 'iyr', 'eyr', 'ecl', 'pid', 'byr', 'hgt']
        @valid = (@fields & required_values).length == 7
    end

    def valid_values?
        if @valid
            @hashed_data.each do |key, value|
                if !@valid
                    break

                elsif key == 'byr'
                    @valid = (1920..2002).include? value.to_i

                elsif key == 'iyr'
                    @valid = (2010..2020).include? value.to_i

                elsif key == 'eyr'
                    @valid = (2020..2030).include? value.to_i

                elsif key == 'hgt'
                    measurement = value[-2..-1]
                    if measurement == 'in'
                        @valid = (59..76).include? value.scan(/\d/).join.to_i
                    elsif measurement == 'cm'
                        @valid = (150..193).include? value.scan(/\d/).join.to_i
                    else
                        @valid = false
                    end

                elsif key == 'hcl'
                    @valid = value.include?('#') && value.scan(/\w/).length == 6

                elsif key == 'ecl'
                    @valid = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(value)

                elsif key == 'pid'
                    @valid = value.scan(/\d/).length == 9

                elsif key == 'cid'

                else
                    @valid = false
                end
            end
        end
    end
end

test_2 = Validator.new
test_2.validate_records
