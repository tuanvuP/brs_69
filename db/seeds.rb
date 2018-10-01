users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

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

3.times do |n|
  name = Faker::Book.genre
  Category.create!(name: name)
end
