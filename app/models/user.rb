class User < ActiveRecord::Base
  acts_as_messageable

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      if auth.credentials.expires_at != nil
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
      user.save!
    end
  end

  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    return "elteck@mail.ru"
    #if false
    #return nil
  end

  searchable do
    text :email
    text :name
  end

end
