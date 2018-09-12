# frozen_string_literal: true

module Query
  class ShortLink::Stats
    def initialize(short_link:)
      @short_link = short_link
    end

    def call()
      sql_query = <<-eos
        SELECT date_trunc('day', created_at) AS date, count(1), device, browser
        FROM short_link_transitions
        WHERE short_link_id = #{@short_link.id}
        GROUP by 1, device, browser
      eos

      ActiveRecord::Base.connection.execute(sql_query)
    end
  end
end
