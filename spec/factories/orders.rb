FactoryBot.define do
  factory :order do
    school_year { "2025-2026" }
    phone { "#{rand(100..999)}-#{rand(100..999)}-#{rand(1000..9999)}" }
    comments { "This is wonderful" }
    association :kit, factory: :kit
    association :user, factory: :teacher
    association :address, factory: :address
  end
end
