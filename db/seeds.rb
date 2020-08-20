# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name: "Example User",
# 			email: "lehiep_admin@lh.com",
# 			password: "123456",
# 			password_confirmation: "123456",
# 			diachi: "Thanh Oai - Hà Nội - Việt Nam",
# 			gioitinh: 1,
# 			sinhnhat: "1991-11-07",
# 			admin: true)
# # Generate a bunch of additional users.
# 99.times do |n|
# 	name = Faker::Name.name
# 	email = "example-#{n+1}@railstutorial.org"
# 	password = "123456"
# 	User.create!(name: name,
# 	email: email,
# 	password: password,
# 	password_confirmation: password,
# 	diachi: "New York-American",
# 	gioitinh: 1,
# 	sinhnhat: "2000-01-01")
# end

users = User.order(:created_at).take(6)
50.times do
	content = Faker::Lorem.sentence(word_count: 5)
	users.each { |user| user.microposts.create!(content: content) }
end