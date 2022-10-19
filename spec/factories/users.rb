FactoryBot.define do

    factory :user do
        name { 'user_general' }
        email { 'user_general@mail.com' }
        password { 'user_general' }
        admin{ 'false' }
    end

    factory :admin_user, class: User do
        name { 'user_admin' }
        email { 'user_admin@mail.com' }
        password { 'user_admin' }
        admin{ 'true' }
    end

end
