

class Api::V1::AuthenticationTokenSerializer
    include FastJsonapi::ObjectSerializer
  
    attributes :id, :auth_token, :device_type, :device_token
  
    attribute :user do |object, params|
      Api::V1::UserSerializer.new(object.user).serializable_hash[:data][:attributes]
    end
  end