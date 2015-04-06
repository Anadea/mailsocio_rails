require 'mail'

module MailsocioRails
  class Delivery < ::Mail::SMTP
    attr_accessor :settings
    def initialize(settings)
      self.settings = default_settings.merge settings
    end

    def deliver!(mail)
      addrs = addresses_from mail, :to, :cc
      bcc = mail[:bcc].to_s

      mail.to = settings[:mailsocio_recipient]
      mail.cc = nil
      mail.bcc = nil

      mail['X-To'] = Hash[addrs.map {|(addr, name)| [addr, {'name' => name}]}].to_json
      mail['X-Bcc'] = bcc
      mail['X-Account-Id'] = settings[:account_id]
      mail['X-Api-Key'] = settings[:api_key]

      super(mail)
    end

    private

    def default_settings
      {
        address:             'app.mailarbor.com',
        port:                25,
        mailsocio_recipient: 'submit@app.mailarbor.com',
        domain:              'localhost.localdomain'
      }
    end

    def addresses_from(mail, *methods)
      methods.flat_map { |method|
        (mail.send(method) || []).zip(mail[method].try(:display_names) || [])
      }
    end
  end
end
