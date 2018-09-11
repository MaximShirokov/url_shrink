class Cmd::ShortLink::Create < Cmd::Base
  string :original_link

  date_time :start_at, default: nil
  string :expire_at, default: nil

  object :user

  validates :original_link, presence: true
  validates :user, presence: true

  def execute
    short_link = ShortLink.create!(
      original_link: original_link,
      user: user,
      short_code: short_code,
      start_at: start_at,
      expire_at: expire_at_time
    )

    short_link.store_in_redis
    short_link.set_short_link_expire(expire_at.to_i) if expire_at.present?
    short_link
  end

  private

  def short_code
    [("a".."z").to_a, ("A".."Z").to_a, ("0".."9").to_a].flatten.sort_by { rand }[0, 5].join
  end

  def expire_at_time
    Time.now + expire_at.to_i if expire_at.present?
  end
end
