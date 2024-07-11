class TwilioTextMessenger
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    client = Twilio::REST::Client.new
    client.messages.create({
      from: Rails.application.secrets.twilio_phone_number || ENV['TWILIO_PHONE_NUMBER'],
      to: @message&.phone_number,
      body: @message&.body
    })
  end
end
