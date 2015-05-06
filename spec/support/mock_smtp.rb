class MockSMTP

  def self.deliveries
    @@deliveries
  end

  def initialize
    @@deliveries = []
  end

  def sendmail(mail, from, to)
    @@deliveries << OpenStruct.new(raw: mail, from: from, to: to, mail: Mail.read_from_string(mail))
    'OK'
  end

  def start(*args)
    if block_given?
      return yield(self)
    else
      return self
    end
  end

  def finish
    return true
  end

  def self.clear_deliveries
    @@deliveries = []
  end

  # in the standard lib: net/smtp.rb line 577
  #   a TypeError is thrown unless this arg is a
  #   kind of OpenSSL::SSL::SSLContext
  def enable_tls(context = nil)
    if context && context.kind_of?(OpenSSL::SSL::SSLContext)
      true
    elsif context
      raise TypeError,
        "wrong argument (#{context.class})! "+
        "(Expected kind of OpenSSL::SSL::SSLContext)"
    end
  end

  def enable_starttls_auto(context = :dummy_ssl_context)
    true
  end

end
