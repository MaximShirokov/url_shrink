class Cmd::ShortLinkTransition::Create < Cmd::Base
  string :short_code
  string :user_agent

  validates :short_code, presence: true
  validates :user_agent, presence: true

  def execute
    ::ShortLinkTransition.create!(
      browser: browser.name,
      device:browser.device.name,
      short_link: short_link
    )
  end

  private

  def browser
    @browser = Browser.new(user_agent)
  end

  def short_link
    @short_link ||= ShortLink.find_by(short_code: short_code)
  end
end
