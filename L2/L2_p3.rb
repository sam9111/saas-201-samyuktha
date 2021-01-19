todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"]
]
categories = []
todos.each do |todo|
  categories.push([todo[1], []]) if categories.find { |category| category[0] == todo[1] } == nil
  categories.each do |category|
    category[1].push(todo[0]) if category[0] == todo[1]
  end
end
categories.each do |todo|
  puts "#{todo[0]}:"
  todo[1].each {|item|
    print "  "
    puts item
  }
end