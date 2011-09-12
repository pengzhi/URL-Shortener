FactoryGirl.define do
  
  factory :locator do
    url 'http://www.schamberger.org/devon.morar?first=this+is+a+field&second=was+it+clear+%28already%29%3F'
  end
  
  factory :invalid_locator, :class => Locator do
    url nil
  end

end
