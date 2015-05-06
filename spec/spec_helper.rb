require 'bundler/setup'

Bundler.require(:default, :test)

require (Pathname.new(__FILE__).dirname + '../lib/mailsocio_rails').expand_path

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  class Net::SMTP
    def self.new(*args)
      MockSMTP.new
    end
  end
end
