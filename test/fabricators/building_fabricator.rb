Fabricator(:building) do
  address { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph }
  floor { Faker::Lorem.sentence }
  roof { Faker::Lorem.sentence }
  window { Faker::Lorem.sentence }
  electrics { Faker::Lorem.sentence }
  damage { Faker::Lorem.paragraph }
end
