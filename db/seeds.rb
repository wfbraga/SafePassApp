# Clear existing data to ensure idempotency
Entry.destroy_all
User.destroy_all

# Create a default user
user = User.create!(
  email: "test@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# Create 10 realistic entries for the user
platforms = [ "Google", "Facebook", "Amazon", "Netflix", "Spotify", "GitHub", "LinkedIn", "Twitter", "Instagram", "Reddit" ]
platforms.each do |platform|
  Entry.create!(
    name: platform,
    username: Faker::Internet.username(specifier: platform),
    password: Faker::Internet.password(min_length: 12, max_length: 20, mix_case: true, special_characters: true),
    url: "https://www.#{platform.downcase}.com",
    user: user
  )
end

puts "Seed completed: 1 User and 10 Entries created."
