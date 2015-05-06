require "spec_helper"

RSpec.describe MailsocioRails::Delivery do
  before(:each) do
    # Reset all defaults back to original state
    Mail.defaults do
      delivery_method MailsocioRails::Delivery, {
        account_id: "some_id",
        api_key: "some_secret"
      }
    end
    MockSMTP.clear_deliveries
  end

  describe "general usage" do
    it "delivers to mailsocio gateway" do
      mail = Mail.deliver do
        from    "roger@moore.com"
        to      "marcel@amont.com"
        subject "invalid RFC2822"
      end

      expect(MockSMTP.deliveries[0].to).to eq [Mail.delivery_method.settings[:mailsocio_recipient]]
    end

    it "wipes to, cc and bcc" do
      mail = Mail.deliver do
        from    "roger@moore.com"
        to      "marcel@amont.com"
        cc      "moore@amont.com"
        bcc     "luke@amont.com"
        subject "invalid RFC2822"
      end

      expect(MockSMTP.deliveries[0].mail.to).not_to eq ["marcel@amont.com"]
      expect(MockSMTP.deliveries[0].mail.cc).not_to be
      expect(MockSMTP.deliveries[0].mail.bcc).not_to be
    end

    it "places to and cc to X-To" do
      mail = Mail.deliver do
        from    "roger@moore.com"
        to      "Dr.Jones <marcel@amont.com>, <unnamed@gmail.com>"
        cc      "AnotherGuy <mike@twitter.com>"
        subject "invalid RFC2822"
      end

      expected_to = {
        "marcel@amont.com" => { "name": "Dr.Jones" },
        "unnamed@gmail.com" => { "name" => nil },
        "mike@twitter.com" => {"name" => "AnotherGuy"}
      }
      expect(MockSMTP.deliveries[0].mail["X-To"].to_s).to eq expected_to.to_json
    end

    it "places bcc to X-Bcc" do
      mail = Mail.deliver do
        from    "roger@moore.com"
        to      "marcel@amont.com"
        bcc     "luke@amont.com"
        subject "invalid RFC2822"
      end

      expect(MockSMTP.deliveries[0].mail["X-Bcc"].to_s).to eq "luke@amont.com"
    end

    it "preserves from and body" do
      mail = Mail.deliver do
        from    "roger@moore.com"
        to      "marcel@amont.com"
        subject "invalid RFC2822"
        body    "Oh come on!"
      end

      expect(MockSMTP.deliveries[0].from).to eq "roger@moore.com"
      expect(MockSMTP.deliveries[0].mail.body.to_s).to eq "Oh come on!"
    end

    it "adds account id and api key" do
      mail = Mail.deliver do
        from    "roger@moore.com"
        to      "marcel@amont.com"
        subject "invalid RFC2822"
      end

      expect(MockSMTP.deliveries[0].mail["X-Account-Id"].to_s).to eq "some_id"
      expect(MockSMTP.deliveries[0].mail["X-Api-Key"].to_s).to eq "some_secret"
    end

  end
end
