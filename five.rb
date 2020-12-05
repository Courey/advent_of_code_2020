class SeatID
    @@input = File.readlines('./data_sets/five.txt')

    def initialize
        @boarding_passes = []
    end

    def find_largest_id
        calculate_ids
        sorted_passes = @boarding_passes.sort
        return sorted_passes[sorted_passes.length - 1]
    end

    def find_seat
        calculate_ids
        sorted_passes = @boarding_passes.sort
        empty_seat(sorted_passes)
    end

    def empty_seat(seats)
        seats.each_index do |seat_index|
            if seats[seat_index] + 1 != seats[seat_index+1]
                return seats[seat_index] + 1
            end
        end
    end

    def calculate_ids
        @@input.each do |ticket|
            @boarding_passes<<seat_id(ticket)
        end
    end

    def row(ticket)
        rows = ticket[0..6].chars
        locate_row = (0..127).to_a

        rows.each do |row|
            if row == 'F'
                locate_row = locate_row.take(locate_row.length/2)
            else
                locate_row = locate_row.drop(locate_row.length/2)
            end
        end

        return locate_row[0]
    end

    def column(ticket)
        columns = ticket[7..9].chars
        locate_column = (0..7).to_a
        columns.each do |column|
            if column == 'L'
                locate_column = locate_column.take(locate_column.length/2)
            else
                locate_column = locate_column.drop(locate_column.length/2)
            end
        end
        return locate_column[0]
    end

    def seat_id(ticket)
        row(ticket) * 8 + column(ticket)
    end

end

test_1 = SeatID.new
puts test_1.find_largest_id

test_2 = SeatID.new
puts test_2.find_seat