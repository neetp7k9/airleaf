module V1
  class Courses < Grape::API
    resource :courses do
      desc "blur search the courses"

      params do
        requires :name, type: String
      end

      get do
        courses = Course.where("name like ?", "%#{params[:name]}%")
      end
    end
  end
end
