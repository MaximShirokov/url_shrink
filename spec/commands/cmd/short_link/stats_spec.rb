require 'rails_helper'

RSpec.describe Cmd::ShortLink::Stats, type: :command do
  let(:user) { create(:user) }
  let(:link) { 'ya.ru' }
  let(:short_link) { create(:short_link, original_link: link, user: user, short_code: 'iojKX') }
  let(:browser) { 'Chrome' }
  let(:device) { 'mac' }
  let!(:short_link_transitions) { create_list(:short_link_transition, 5, browser: browser, device: device, short_link: short_link) }

  describe 'stats transitions for short link' do
    it 'return array of transitions' do
      result = described_class.run!(short_link: short_link).first

      expect(result['count']).to eq(short_link_transitions.count)
      expect(result['device']).to eq(device)
      expect(result['browser']).to eq(browser)
    end
  end
end
