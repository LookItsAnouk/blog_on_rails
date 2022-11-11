# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



Post.destroy_all
Comment.destroy_all
User.destroy_all

PASSWORD ="test"


super_user = User.create(
    first_name: "Admin",
    last_name: "User",
    email: "admin@user.com",
    password: PASSWORD,
    admin?: true
)

10.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}@#{last_name}.com",
    password: PASSWORD,
    admin?: false
    )
end

users = User.all

50.times do
    p = Post.create(
        title: Faker::Marketing.buzzwords + rand(100_000).to_s,
        body: Faker::GreekPhilosophers.quote + " " + Faker::Lorem.characters(number: 50),
        user: users.sample
    )
    if p.valid?
        rand(1..5).times do
            Comment.create(body: Faker::Hacker.say_something_smart, post: p, user: users.sample)
        end
    end

end

posts = Post.all
comments = Comment.all

puts "done generating"