# This seed data can be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Create one user with no associated org
User.create!(
  name: "Joi Jones",
  email: "joi@company.com",
  password: "123456"
)

# Create orgs
3.times do 
  org = Organisation.create!(
    name: Faker::Company.name,
    hourly_rate: Faker::Number.decimal(l_digits: 2)
  )
end

# Create employees for each organisation
Organisation.all.each do |org|
  3.times do
    org.users.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password(min_length: 6)
    )
  end
end

# Create shifts for each employee, except first user with no org membership yet
User.all.each do |user|
  # Generate standard shifts
  if (user.id != 1)
    3.times do
      start_hr = rand(0..12)
      finish_hr = start_hr + rand(6..10)
      day = rand(1..20)
  
      user.shifts.create!(
        start: DateTime.new(2021,7,day,start_hr),
        finish: DateTime.new(2021,7,day,finish_hr),
        break_length: [15, 30, 45, 60].sample
      )
    end
  end

  # Generate overnight shift
  user.shifts.create!(
    start: DateTime.new(2021,7,21,18,30),
    finish: DateTime.new(2021,7,22,3),
    break_length: 45
  )
end