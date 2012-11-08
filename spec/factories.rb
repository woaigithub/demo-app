FactoryGirl.define do
  factory :user do
    name      "michael hartl"
    email     "asdf@123.com"
    password  "123456"
    password_confirmation "123456"
    
    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "lorem ipsum"
    user
  end
end
