names = [['Jhumpa', 'Lahiri'], ['J. K', 'Rowling'], ['Devdutt', 'Pattanaik']]

res=names.map do |name|
  name.join(' ')
end
pp res
