FactoryBot.define do
  factory :reservation_line_item do
    reserveable_type { "MyString" }
    reservable_id { "" }
    minimum_version { "" }
    maximum_version { "" }
    reservation { nil }
  end
end
