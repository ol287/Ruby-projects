# Command-line Calculator in Ruby

def addition(num1, num2)
  num1 + num2
end

def subtraction(num1, num2)
  num1 - num2
end

def multiplication(num1, num2)
  num1 * num2
end

def division(num1, num2)
  if num2 == 0
    "Cannot divide by zero"
  else
    num1 / num2.to_f
  end
end

def calculator
  puts "Welcome to Ruby Calculator!"
  loop do
    puts "Select operation: 1) Addition 2) Subtraction 3) Multiplication 4) Division 5) Exit"
    operation = gets.chomp

    break if operation == '5'

    puts "Enter the first number:"
    num1 = gets.chomp.to_f

    puts "Enter the second number:"
    num2 = gets.chomp.to_f

    result = case operation
             when '1'
               addition(num1, num2)
             when '2'
               subtraction(num1, num2)
             when '3'
               multiplication(num1, num2)
             when '4'
               division(num1, num2)
             else
               "Invalid operation selected"
             end

    puts "The result is: #{result}"
    puts "---------------------------------"
  end
  puts "Thank you for using Ruby Calculator. Goodbye!"
end

calculator
