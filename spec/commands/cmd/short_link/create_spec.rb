require 'rails_helper'

RSpec.describe Cmd::ShortLink::Create, type: :command do
  let(:user) { create(:user) }
  let(:link) { 'ya.ru' }
  let(:link_with_http) { 'https://google.com' }
  let(:expire_at) { '3600' }

  describe 'create short link' do
    before do
      @params1 = {
        original_link: link,
        user: user
      }

      @params2 = {
        original_link: link_with_http,
        expire_at: expire_at,
        user: user
      }
    end

    it 'without protocol and expire time' do
      expect {
        described_class.run!(@params1)
      }.to change { ShortLink.count }.by(1)

      expect(ShortLink.last.original_link).to match(/\Ahttp:\/\//)
      expect(ShortLink.last.short_code).to be
    end

    it 'with protocol and expire time' do
      expect {
        described_class.run!(@params2)
      }.to change { ShortLink.count }.by(1)

      expect(ShortLink.last.original_link).to match(/\Ahttps:\/\//)
      expect(ShortLink.last.short_code).to be
      expect(ShortLink.last.expire_at).to be_the_same_time_as(ShortLink.last.created_at + expire_at.to_i)
    end
  end
end
