FactoryBot.define do
  factory :reservation do
    started_at { "2023-09-02 14:37:09" }
    ended_at { "2023-09-02 14:37:09" }
    status { "requested" }
    reserved_by { nil }
  end
end
