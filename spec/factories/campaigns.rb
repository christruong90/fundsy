# this file will be used by FactoryGirl gem to generate Campaign records
# You should always make sure that factories generate valid records.
FactoryGirl.define do
  factory :campaign do
    # we use sequence when we want to have one of our record be unique so we
    # have an access to a counter variable `n` which we can use to generate
    # the unique field.
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}" }
    body             { Faker::Lorem.paragraph         }
    goal             { 10 + rand(100000)              }
    end_date         60.days.from_now
  end
end
