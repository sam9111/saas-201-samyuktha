def salute(name,greeting)
  "#{greeting.capitalize} Mr. #{name.split.last.capitalize}"
end
puts salute("Nelson Rolihlahla Mandela", "hello")
puts salute("Sir Alan Turing", "welcome")
