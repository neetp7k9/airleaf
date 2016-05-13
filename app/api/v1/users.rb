module V1
  class Users < Grape::API
    resource :users do
      desc "list all users"

      get do
        User.all
      end

      desc "find user by id"

      params do
        requires :id, type: Integer
      end

      get "/id" do
        user = User.find_by(id: params[:id])
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
      end

      desc "delete a user by id"

      params do
        requires :id, type: Integer
      end

      delete do
        user = User.find_by(id: params[:id])
        user.destroy
        User.all
      end

      desc "update a user's info"

      params do
        requires :id, type: Integer
        optional :name, default: nil, type: String
        optional :email, default: nil, type: String
        optional :password, default: nil, type: String
      end

      patch do
        user = User.find_by(id: params[:id])
        if params[:name]
          user.name = params[:name]
        end
        if params[:email]
          user.email = params[:email]
        end
        if params[:password]
          user.password = params[:password]
        end
        user.save!
      end
      # desc 'test'
      # params do
      #   requires :answer, type: Integer
      # end

      # get '/testing' do
      #   {"answer" => params[:answer]}
      # end
    end
  end
end
