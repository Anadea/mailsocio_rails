require 'actionmailer'
require 'mailsocio_rails/delivery'
require 'mailsocio_rails/version'

ActionMailer::Base.add_delivery_method :mailsocio, MailsocioRails::Delivery

module MailsocioRails
end
