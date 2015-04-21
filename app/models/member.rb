class Member < ActiveRecord::Base
  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |member|
      member.provider = auth["provider"]
      member.uid = auth["uid"]
      member.name = auth["info"]["name"]
      member.profile_pic = auth["info"]["image"]
    end
  end
end