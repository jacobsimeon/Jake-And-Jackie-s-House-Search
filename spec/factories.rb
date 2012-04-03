FactoryGirl.define do
  factory :listing do
    html "this isn't real html"
    mls_number "123456789"
    short_sale false
    street_address "123 Main St"
    city "Boise"
    state "ID"
    zip "83642"
    price "123,000"
    interested false
    not_interested false
  end
end
