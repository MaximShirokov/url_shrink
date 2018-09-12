class Cmd::ShortLink::Stats < Cmd::Base
  object :short_link

  validates :short_link, presence: true

  def execute
    query_result = Query::ShortLink::Stats.new(short_link: short_link).call

    query_result.to_a
  end
end
