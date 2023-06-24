FactoryBot.define do
  factory :user do
    name                  {Faker::Name.initials(number: 2)}
    birthday              {'1930-01-01'}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6) }
    password_confirmation {password}
    test_attempts         {2}
    average_score         {5}

    after(:build) do |message|
      message.profile_picture.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end