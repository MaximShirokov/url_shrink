class Cmd::Base < ActiveInteraction::Base
  class ValidationError < Exception; end

  private

  def validate!(condition, errors_hash)
    if Rails.env.development? || Rails.env.test?
      errors.messages
    end
    unless condition
      errors_hash.each { |key, value| errors.add(key, value) }
      raise ValidationError
    end
  end
end
