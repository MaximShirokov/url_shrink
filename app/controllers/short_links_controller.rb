class ShortLinksController < ApplicationController
  before_action :set_short_link, only: [:stats]
  before_action :get_original_link, only: [:show]

  def new
    @short_link = ShortLink.new
  end

  def show
    if @original_link.present?
      redirect_to @original_link
      Cmd::ShortLinkTransition::Create.run(short_code: params[:short_code], user_agent: request.user_agent)
    else
      render :show
    end
  end

  def create
    outcome = Cmd::ShortLink::Create.run(short_link_params.to_h.merge({user: current_user}))
    @short_link = outcome.result

    if outcome.valid?
      render partial: 'short_link', locals: {short_link: @short_link}
    end
  end

  private

  def get_original_link
    @original_link = ShortLink.fetch_from_redis_by(short_code: params[:short_code])
  end

  def set_short_link
    @short_link = ShortLink.find_by(short_code: params[:short_code])
  end

  def short_link_params
    params.require(:short_link).permit(:original_link, :expire_at)
  end
end
