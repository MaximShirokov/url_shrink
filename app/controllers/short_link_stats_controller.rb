class ShortLinkStatsController < ApplicationController
  before_action :set_short_link

  def show
    @stats = ShortLink::Stats.new(short_link: @short_link).call()
  end

  private

  def set_short_link
    @short_link = ShortLink.find_by(short_code: params[:short_code])
  end
end
