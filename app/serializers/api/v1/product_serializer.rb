class Api::V1::ProductSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
    :name,
    :price,
    :description  
  
end
