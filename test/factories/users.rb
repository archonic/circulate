FactoryBot.define do
  factory :user do
    library { Library.first || create(:library) }

    email
    password { "password" }

    factory :admin_user do
      role { "admin" }
    end

    factory :super_admin_user do
      role { "super_admin" }
    end
    
    after(:build) { |user| user.skip_confirmation! }
  end

  factory :unconfirmed_user, class: User do
    library { Library.first || create(:library) }

    email
    password { "password" }

    after(:build) { |user| user.skip_confirmation_notification! }
  end
end
