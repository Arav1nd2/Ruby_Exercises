require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def overdue?
    due_date < Date.today
  end

  def due_later?
    due_date > Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.add_task(hash)
    create!(todo_text: hash[:todo_text], due_date: Date.today + hash[:due_in_days], completed: false)
  end

  def self.show_list()
    overdue = where("due_date < ?", Date.today).map { |t| t.to_displayable_string }
    today = where("due_date = ?", Date.today).map { |t| t.to_displayable_string }
    later = where("due_date > ?", Date.today).map { |t| t.to_displayable_string }
    puts "My Todo-List\n\nOverdue\n"
    puts overdue
    puts "\n\nDue Today"
    puts today
    puts "\n\nDue Later"
    puts later
  end

  def self.mark_as_complete!(todo_id)
    todo = find(todo_id)
    todo.completed = true
    todo.save
    todo
  end
end
