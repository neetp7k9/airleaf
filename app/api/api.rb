class API < Grape::API
  prefix 'api'
  format :json
  version 'v1', using: :path
  mount V1::Users
  mount V1::Notes
  mount V1::Courses
end
