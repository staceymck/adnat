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

# Create shifts using virtual attribute formats expected from frontend forms:
  # start_time: "hh:mm"
  # date: "yyyy-mm-dd"
  # finish_time: "hh:mm"

User.all.each do |user|
  if (user.id != 1)
    # Generate standard shifts
    3.times do
      start_hr = rand(0..9)
      start_min = [5, 15, 30].sample
      finish_hr = start_hr + rand(6..10)
      finish_min = [15, 30, 45].sample
      day = rand(1..20)
      month = rand(1..7)
      year = 2021
  
      user.shifts.create!(
        date: "#{year}-#{month}-#{day}",
        start_time: "0#{start_hr}:#{start_min}",
        finish_time: "#{finish_hr}:#{finish_min}",
        break_length: [15, 30, 45, 60].sample
      )
    end

    # Generate overnight shift
    day = rand(1..20)
    month = rand(1..7)
    year = 2021

    user.shifts.create!(
      date: "#{year}-#{month}-#{day}",
      start_time: "18:00",
      finish_time: "02:00",
      break_length: 45
    )
  end
end