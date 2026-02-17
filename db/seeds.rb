# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Follow.destroy_all
Like.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

# Users
alice = User.create!(email: "alice@example.com", password: "alices_password")
bob = User.create!(email: "bob@example.com", password: "bobs_password")
cara = User.create!(email: "cara@example.com", password: "caras_password")

# Bios
alice.profile.update!(bio: "Alice here! Rails enjoyer.")
bob.profile.update!(bio: "Bob. Likes backends and bikes.")
cara.profile.update!(bio: "Cara. Frontend-curious.")

# Posts
post1 = alice.posts.create!(body: "Hello from Alice!")
post2 = bob.posts.create!(body: "Bob has entered the chat.")
post3 = cara.posts.create!(body: "Cara testing seeds.")

# Follows
Follow.create!(follower: alice, followed: bob, status: :accepted)
Follow.create!(follower: bob, followed: cara, status: :pending)

# Likes
Like.create!(user: bob, post: post1)
Like.create!(user: cara, post: post2)
Like.create!(user: alice, post: post3)

# Comments
Comment.create!(user: cara, post: post1, body: "Nice post!")
Comment.create!(user: bob, post: post3, body: "Welcome!")
Comment.create!(user: alice, post: post2, body: "Wow!")
