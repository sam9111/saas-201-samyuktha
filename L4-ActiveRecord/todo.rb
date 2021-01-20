require "active_record"
require "date"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts self.where("due_date<?", Date.today).to_displayable_list
    puts "\n\n"

    puts "Due Today\n"
    puts self.where("due_date=?", Date.today).to_displayable_list
    puts "\n\n"

    puts "Due Later\n"
    puts self.where("due_date>?", Date.today).to_displayable_list
    puts "\n\n"
  end

  def self.add_task(new_todo)
    todo = Todo.new
    todo.todo_text = new_todo[:todo_text]
    todo.due_date = Date.today + new_todo[:due_in_days]
    todo.completed = false
    todo.save
    todo
  end

  def self.mark_as_complete!(id)
    todo = self.find(id)
    todo.completed = true
    todo.save
    todo
  end
end
