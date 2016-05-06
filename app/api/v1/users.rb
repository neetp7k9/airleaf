module V1
  class Users < Grape::API
    resource :users do
      desc "list all users"

      get do
        User.all
      end

      desc "Create a new user"

      params do
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
      end

      post do
        user = User.new
        user.email = params[:email]
        user.password = params[:password]
        user.name = params[:name]
        user.save!

        # return { name: user.name }
        # User.create({
        #   name: params[:name],
        #   email: params[:email],
        #   password: params[:password]
        #   })
      end

      desc 'test'
      params do
        requires :answer, type: Integer
      end

      get '/testing' do
        {"answer" => params[:answer]}
      end
    end
  end
end
