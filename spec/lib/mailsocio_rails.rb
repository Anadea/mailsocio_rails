require "spec_helper"

RSpec.describe "mailsocio rails main file" do
  it "adds delivery_method" do
    expect(ActionMailer::Base.delivery_methods).to include(mailsocio: MailsocioRails::Delivery)
  end

  it "adds configuration method" do
    expect(ActionMailer::Base).to respond_to(:mailsocio_settings=)
  end
end
