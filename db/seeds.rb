# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

read = open(url).read
ingredients = JSON.parse(read)

ingredients['drinks'].each do |drink|
    Ingredient.create!(name: drink.values[0])
end

url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
file = open(url).read
readable_file = JSON.parse(file)

readable_file["drinks"].first(6).each_with_index do |item, index|
  c = Cocktail.create(name: item["strDrink"])
  puts "We passed coktail create"
  puts item["strDrinkThumb"]
  c.photo.attach(io: open(item["strDrinkThumb"]), filename: SecureRandom.hex(8))

  puts "photo attached"
end