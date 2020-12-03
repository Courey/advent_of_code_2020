class ExpenseReport

    def initialize(expenses, depth)
        @expenses = expenses
        @depth = depth
        @results = nil
    end

    def calculate_expenses
        @expenses.each do |expense|
            if @depth == 2
                find_final_result(expense)
            elsif @depth == 3
                @expenses.each do |secondary_expense|
                    sum_first_expenses = expense + secondary_expense
                    multiplier = expense * secondary_expense
                    find_final_result(sum_first_expenses, multiplier)
                end
            else
                @results = "Depth unavailable."
                break
            end
        end
        puts @results
    end

    def find_final_result(expense, multiplier=expense)
        diff = (2020 - expense)
        if @expenses.include? diff
            @results = diff * multiplier
        end
    end

end


def expenses
    converted_expenses = []
    f = File.readlines('./data_sets/one_data.rb')
    f.each{ |line| converted_expenses << line.to_i}

    return converted_expenses
end

expense_report = expenses
challenge_1 = ExpenseReport.new(expense_report, 2)
challenge_1.calculate_expenses

challenge_2 = ExpenseReport.new(expense_report, 3)
challenge_2.calculate_expenses

challenge_unavailiable = ExpenseReport.new(expense_report, 4)
challenge_unavailiable.calculate_expenses
