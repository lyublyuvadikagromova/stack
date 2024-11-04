require 'minitest/autorun'
require_relative 'task8'

class TaskManagerTest < Minitest::Test
  def setup
    @manager = TaskManager.new
    @manager.instance_variable_set(:@tasks, [])
  end

  def test_add_task
    @manager.add_task_directly('Test Task', Date.today.to_s)
    assert_equal 1, @manager.instance_variable_get(:@tasks).size
    assert_equal 'Test Task', @manager.instance_variable_get(:@tasks).first[:title]
  end

  def test_delete_task
    @manager.add_task_directly('Test Task', Date.today.to_s)
    @manager.delete_task_directly(0)
    assert_equal 0, @manager.instance_variable_get(:@tasks).size
  end

  def test_edit_task
    @manager.add_task_directly('Test Task', Date.today.to_s)
    @manager.edit_task_directly(0, 'Updated Task', (Date.today + 1).to_s)  # Завтра
    edited_task = @manager.instance_variable_get(:@tasks).first
    assert_equal 'Updated Task', edited_task[:title]
    assert_equal (Date.today + 1).to_s, edited_task[:deadline]
  end

  def test_mark_complete
    @manager.add_task_directly('Incomplete Task', Date.today.to_s)
    @manager.mark_complete_directly(0)
    completed_task = @manager.instance_variable_get(:@tasks).first
    assert_equal true, completed_task[:completed]
  end
end

