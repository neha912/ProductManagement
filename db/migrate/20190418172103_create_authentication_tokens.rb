class CreateAuthenticationTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :authentication_tokens do |t|
      t.string :auth_token
      t.string :device_type
      t.string :device_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
