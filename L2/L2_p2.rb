books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]

books.each.with_index do |book,i|
  puts "#{book} was written by #{authors[i]}"
end
