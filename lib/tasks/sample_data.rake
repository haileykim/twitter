namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Hailey Kim",
                 email: "heawon.hailey1@gmail.com",
                 password: "myhye1",
                 password_confirmation: "myhye1",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.limit(6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end