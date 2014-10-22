namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Dmitry",
                         email: "rtrtyyyyyh@mail.ru",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)
    user = User.create!(name: "Kozyr",
                        email: "kozyr@example.ru",
                        password: "foobar",
                        password_confirmation:"foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end