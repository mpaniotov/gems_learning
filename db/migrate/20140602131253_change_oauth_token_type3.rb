class ChangeOauthTokenType3 < ActiveRecord::Migration
  def change
    drop_table :users
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.text :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
