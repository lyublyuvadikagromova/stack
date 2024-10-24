class Person
  def initialize(name, age)
    if name.is_a?(String) && !name.empty?
      @name = name
    else
      raise "invalid name"
    end

    if age.is_a?(Integer) && age >= 0
      @age = age
    else
      raise "invalid age"
    end
  end

  def increase_age
    @age += 1
  end

  def display_info
    puts "name: #{@name}, age: #{@age}"
  end
end

print "enter your name: "
name = gets.chomp

print "enter your age: "
age_input = gets.chomp

if age_input.to_i.to_s == age_input
  age = age_input.to_i

  begin
    person = Person.new(name, age)
    person.increase_age
    person.display_info

  rescue => e
    puts "error: #{e.message}"
  end
else
  puts "invalid input for age"
end
