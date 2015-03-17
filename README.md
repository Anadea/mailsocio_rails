# Mailsocio Rails

ActionMailer plugin to use mailsocio to deliver emails

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mailsocio_rails', github: 'Anadea/mailsocio_rails', tag: 'v0.0.2'
```

And then execute `bundle`.

## Usage

Configure ActionMailer as follows:

```ruby
# config/application.rb

config.action_mailer.delivery_method = :mailsocio
config.action_mailer.mailsocio_settings = {
  account_id: '<your account id>',
  api_key: '<your account api key>'
}
```

You're done!

## Customization

You can also override gem defaults:

```ruby
config.action_mailer.mailsocio_settings = {
  account_id: '<your account id>',
  api_key: '<your account api key>',

  address:             'app.mailarbor.com',        # This can be any smtp server
  port:                25,                         # that is capable to
  domain:              'localhost.localdomain'     # deliver emails.

  mailsocio_recipient: 'submit@app.mailarbor.com', # If you change this,
                                                   # bad things can happen.
}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mailsocio_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
