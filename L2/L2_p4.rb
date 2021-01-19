books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]

hash={}
authors.each_with_index do |author,i|
  hash[author.split[0].downcase.to_sym]=books[i]
end
pp hash