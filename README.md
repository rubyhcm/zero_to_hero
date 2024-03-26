# Telegram
Take Telegram API Token
Connect to an example API: ```https://api.telegram.org/bot{{API_TOKEN_KEY}}/getMe```

Send messages: ```https://api.telegram.org/bot6379697986:AAGSPiv82e1YWf9UAOsbilii8OvyxQrbGU0/sendMessage?chat_id={{chat_id or group_id}}&text=abc```

# Devise
```rails generate devise:install```
Add ```rails generate devise MODEL``` to config/environments/development.rb

# Create Post and send to Telegram
```rails g scaffold Article title content:text --no-help --no-assets --no-controller-specs --no-view-specs --no-test-framework --no-jbuilder```
```rails g mailer TelegramMailer```

# 








# NOTE
Rollback
```bin/rails destroy scaffold Post```
