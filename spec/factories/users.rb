FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname                 { Faker::Name.initials(number: 3)}
    email                    { Faker::Internet.email}
    password                 { "e6" + Faker::Internet.password(min_length: 6) }
    password_confirmation    { password }
    last_name                { person.last.kanji }
    first_name               { person.first.kanji }
    last_name_kana           { person.last.katakana }
    first_name_kana          { person.first.katakana }
    date_of_birth            { Faker::Date.backward }
  end
end