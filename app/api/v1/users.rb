module V1
  class Users < Grape::API
    resource :users do
      desc "list all users"

      get do
        User.all
      end
    end
  end
end
