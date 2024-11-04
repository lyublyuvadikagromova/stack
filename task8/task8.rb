require 'json'
require 'date'

class TaskManager
  FILE_NAME = 'tasks.json'

  def initialize
    @tasks = load_tasks
  end

  def add_task
    puts "Enter task title:"
    title = gets.chomp
    puts "Enter deadline (in YYYY-MM-DD format):"
    deadline_str = gets.chomp
    deadline = parse_date(deadline_str)
    return unless deadline

    task = { title: title, deadline: deadline, completed: false }
    @tasks << task
    save_tasks
    puts "Task added"
  end

  def add_task_directly(title, deadline)
    task = { title: title, deadline: deadline, completed: false }
    @tasks << task
    save_tasks
  end

  def delete_task
    list_tasks
    puts "Enter task number to delete:"
    index = gets.to_i - 1
    if valid_index?(index)
      @tasks.delete_at(index)
      save_tasks
      puts "Task deleted!"
    else
      puts "Invalid task number."
    end
  end

  def delete_task_directly(index)
    @tasks.delete_at(index) if valid_index?(index)
    save_tasks
  end

  def edit_task
    list_tasks
    puts "Enter task number to edit:"
    index = gets.to_i - 1
    if valid_index?(index)
      puts "Enter new title:"
      @tasks[index][:title] = gets.chomp
      puts "Enter new deadline (YYYY-MM-DD):"
      deadline_str = gets.chomp
      new_deadline = parse_date(deadline_str)
      if new_deadline
        @tasks[index][:deadline] = new_deadline
        save_tasks
        puts "Task updated"
      else
        puts "Invalid date format"
      end
    else
      puts "Invalid task number"
    end
  end

  def edit_task_directly(index, new_title, new_deadline)
    if valid_index?(index)
      @tasks[index][:title] = new_title
      @tasks[index][:deadline] = new_deadline
      save_tasks
    end
  end

  def filter_tasks
    puts "Filter by (1 - Completed, 2 - Incomplete, 3 - By deadline):"
    option = gets.to_i
    case option
    when 1
      display_tasks(@tasks.select { |task| task[:completed] })
    when 2
      display_tasks(@tasks.select { |task| !task[:completed] })
    when 3
      puts "Enter deadline (YYYY-MM-DD):"
      deadline_str = gets.chomp
      deadline = parse_date(deadline_str)
      display_tasks(@tasks.select { |task| task[:deadline] <= deadline }) if deadline
    else
      puts "Invalid choice"
    end
  end

  def mark_complete
    list_tasks
    puts "Enter task number to mark as completed:"
    index = gets.to_i - 1
    if valid_index?(index)
      @tasks[index][:completed] = true
      save_tasks
      puts "Task marked as completed"
    else
      puts "Invalid task number"
    end
  end

  def mark_complete_directly(index)
    if valid_index?(index)
      @tasks[index][:completed] = true
      save_tasks
    end
  end

  def list_tasks
    puts "Tasks:"
    @tasks.each_with_index do |task, index|
      status = task[:completed] ? "Completed" : "Incomplete"
      puts "#{index + 1}. #{task[:title]} - #{task[:deadline]} - #{status}"
    end
  end

  private

  def load_tasks
    File.exist?(FILE_NAME) ? JSON.parse(File.read(FILE_NAME), symbolize_names: true) : []
  rescue
    []
  end

  def save_tasks
    File.write(FILE_NAME, JSON.pretty_generate(@tasks))
  rescue
    puts "Error saving tasks"
  end

  def parse_date(date_str)
    Date.parse(date_str)
  rescue ArgumentError
    puts "Invalid date format"
    nil
  end

  def valid_index?(index)
    index >= 0 && index < @tasks.size
  end

  def display_tasks(tasks)
    tasks.each_with_index do |task, index|
      status = task[:completed] ? "Completed" : "Incomplete"
      puts "#{index + 1}. #{task[:title]} - #{task[:deadline]} - #{status}"
    end
  end
end

manager = TaskManager.new

loop do
  puts "Select an action:\n1 - Add Task\n2 - Delete Task\n3 - Edit Task\n4 - Filter Tasks\n5 - Mark as Completed\n6 - List Tasks\n0 - Exit"
  choice = gets.to_i
  case choice
  when 1
    manager.add_task
  when 2
    manager.delete_task
  when 3
    manager.edit_task
  when 4
    manager.filter_tasks
  when 5
    manager.mark_complete
  when 6
    manager.list_tasks
  when 0
    break
  else
    puts "Invalid choice"
  end
end
