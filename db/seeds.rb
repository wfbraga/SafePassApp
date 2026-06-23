# Clear existing data to ensure idempotency
Entry.destroy_all
User.destroy_all

# Create a default user
user = User.create!(
  email: "h@h.com",
  password: "asdfff",
  password_confirmation: "asdfff"
)
user1 = User.create!(
  email: "f@f.com",
  password: "asdfff",
  password_confirmation: "asdfff"
)
user2 = User.create!(
  email: "a@a.com",
  password: "asdfff",
  password_confirmation: "asdfff"
)
user3 = User.create!(
  email: "d@d.com",
  password: "asdfff",
  password_confirmation: "asdfff"
)
user4 = User.create!(
  email: "g@g.com",
  password: "asdfff",
  password_confirmation: "asdfff"
)
user5 = User.create!(
  email: "j@j.com",
  password: "asdfff",
  password_confirmation: "asdfff"
)

# Create 10 realistic entries for the user
platforms = [ "Google", "Facebook", "Amazon", "Netflix", "Spotify", "GitHub", "LinkedIn", "Twitter", "Instagram", "Reddit" ]
User.all.each do |user|
  platforms.each do |platform|
    Entry.create!(
      name: platform,
      username: user.email,
      password: Faker::Internet.password(min_length: 12, max_length: 20, mix_case: true, special_characters: true),
      url: "https://www.#{platform.downcase}.com",
      user: user
    )
  end
end


puts "Seed completed: several User and Entries created."
