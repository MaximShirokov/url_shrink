class Cmd::Base < ActiveInteraction::Base
  class ValidationError < Exception; end

  private

  def validate!(condition, errors_hash)
    if Rails.env.development? || Rails.env.test?
      # NOTE: raise I18n translation error in dev or test mode
      errors.messages
    end
    unless condition
      errors_hash.each { |key, value| errors.add(key, value) }
      raise ValidationError
    end
  end
end
