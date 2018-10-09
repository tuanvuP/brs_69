User.create!(name: "Admin",
             email: "admin@admin.com",
             password: "admin123",
             password_confirmation: "admin123",
             role: 1)

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

5.times do |n|
  name = Faker::Book.genre
  Category.create!(name: name)
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

99.times do |n|
  title = Faker::Book.title
  description = "Book's description-#{n+1}"
  author = Faker::Book.author
  category_id = [1, 2, 3, 4, 5].sample
  Book.create!(title: title,
               description: description,
               author: author,
               category_id: category_id)
end
