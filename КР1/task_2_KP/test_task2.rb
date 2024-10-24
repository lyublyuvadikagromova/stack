require 'minitest/autorun'
require_relative 'task_2'

class TestPerson < Minitest::Test
  def test_initialize_with_valid_data
    person = Person.new("маша", 12)
    assert_equal "маша", person.instance_variable_get(:@name)
    assert_equal 12, person.instance_variable_get(:@age)
  end

  def test_initialize_with_invalid_name
    assert_raises(RuntimeError, "invalid name") { Person.new("", 12) }
    assert_raises(RuntimeError, "invalid name") { Person.new(nil, 12) }
  end

  def test_initialize_with_invalid_age
    assert_raises(RuntimeError, "invalid age") { Person.new("маша", -1) }
    assert_raises(RuntimeError, "invalid age") { Person.new("маша", "twelve") }
  end

  def test_increase_age
    person = Person.new("гена", 55)
    person.increase_age
    assert_equal 56, person.instance_variable_get(:@age)
  end
end
