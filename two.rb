=begin
a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.

For example, suppose you have the following list:

1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc

Each line gives the password policy and then the password.
The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid.
For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

In the above example, 2 passwords are valid. The middle password, cdefg, is not;
it contains no instances of b, but needs at least 1.
The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.

How many passwords are valid according to their policies?
=end

def process_file
    file='./data_sets/two_data.txt'
    results_1 = []
    results_2 = []

    File.readlines(file).each do |line|
        formatted_data = format_data(line)

        if is_valid_1(formatted_data)
            results_1.push(formatted_data["password"])
        end

        if is_valid_2(formatted_data)
            results_2.push(formatted_data["password"])
        end
    end

    puts results_1.length()
    puts results_2.length() #454
end

def format_data(entry)
    split_data = entry.split(' ')
    rule = split_data[0].split('-')

    return Hash[
        "min" => Integer(rule[0]),
        "max" => Integer(rule[1]),
        "letter" => split_data[1].tr(':', ''),
        "password" => split_data[2]
    ]
end

def is_valid_1(data)
    count = data["password"].count data["letter"]
    return ((count >= data["min"]) && (count <= data["max"]))
end

def is_valid_2(data)
    char_array = data["password"].chars
    both = ((char_array[data["min"] - 1] == data["letter"]) && (char_array[data["max"] - 1] == data["letter"]))
    either = ((char_array[data["min"] - 1] == data["letter"]) || (char_array[data["max"] - 1] == data["letter"]))

    return (!both && either)
end

process_file()