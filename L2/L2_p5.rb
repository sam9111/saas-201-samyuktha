todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"]
]

todoHash={}

todos.each do |todo|
  category=todo[1].to_sym
  todoHash[category]=[] if !todoHash.has_key?(category)
  todoHash.each do |key,items|
    if key==category
      items.push(todo[0])
    end
  end
end
pp todoHash