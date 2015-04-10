# Mailsocio Rails

Плагин к ActionMailer для использования mailsocio для отправки электронной почты.

## Установка

Строчка в Гемфайл:

```ruby
gem 'mailsocio_rails'
```

Ну и выполните `bundle`.

## Использование

Сконфигурируйте ActionMailer вот так:

```ruby
# config/application.rb

config.action_mailer.delivery_method = :mailsocio
config.action_mailer.mailsocio_settings = {
  account_id: '<your account id>',
  api_key: '<your account api key>'
}
```

Готово!
