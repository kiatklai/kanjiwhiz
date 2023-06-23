# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: "sample@testtest",
  password:  "a123456",
  password_confirmation: "a123456",
  name:  "admin",
  birthday: "1985-10-10",
  admin: true)