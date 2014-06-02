class ChangeOauthTokenType < ActiveRecord::Migration
  def change
    def up
      change_column :users, :oauth_token, :string
    end

    def down
      change_column :users, :oauth_token, :text
    end
  end
end
