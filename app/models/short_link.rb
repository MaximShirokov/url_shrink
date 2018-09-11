class ShortLink < ApplicationRecord
  belongs_to :user
  has_many :transitions, class_name: 'ShortLinkTransition', foreign_key: :short_link_id

  def store_in_redis
    $redis.set(redis_short_link_key, original_link)
  rescue
    retry
  end

  def set_short_link_expire(expire_at)
    $redis.expire(redis_short_link_key, expire_at)
  rescue
    retry
  end

  def fetch_from_redis
    $redis.get(redis_short_link_key)
  rescue Redis::CannotConnectError
    sleep 5
    retry
  end

  def redis_short_link_key
    "short-link:#{short_code}"
  end

  def self.fetch_from_redis_by(short_code:)
    $redis.get("short-link:#{short_code}")
  end
end
