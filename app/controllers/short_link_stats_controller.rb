class ShortLinkStatsController < ApplicationController
  before_action :set_short_link

  def show
    @stats = Cmd::ShortLink::Stats.run(short_link: @short_link).result
  end

  private

  def set_short_link
    @short_link = ShortLink.find_by(short_code: params[:short_code])
  end
end
