# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

i = 0

10.times do
    u = User.create(name: Faker::Name.unique.name, email: Faker::Internet.unique.email, password_digest: "password#{i}", age: rand(13..50), bio: Faker::Quote.famous_last_words)

    3.times do 
        u.posts.build(content: Faker::Quote.yoda, likes: 0).save
    end

    i += 1
end

i = 0
users = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]
friends = [2,3,9,8,9,7,1,6,2,10,8,1,6,1,7,9,4,5,1,2]

20.times do
    Friendship.create(user_id: users[i], friend_id: friends[i], status: "accepted")
    i += 1
end

100.times do
    Comment.create(user: User.all.sample, post: Post.all.sample, content: Faker::Movie.quote)
end