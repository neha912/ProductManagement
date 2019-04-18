class Api::V1::UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
    :email,
    :first_name,
    :last_name
  
  end
