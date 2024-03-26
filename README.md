# Telegram
Take Telegram API Token
Connect to an example API: ```https://api.telegram.org/bot{{API_TOKEN_KEY}}/getMe```

Send messages: ```https://api.telegram.org/bot6379697986:AAGSPiv82e1YWf9UAOsbilii8OvyxQrbGU0/sendMessage?chat_id={{chat_id or group_id}}&text=abc```

# Devise
```rails generate devise:install```
```rails generate devise User```
Add ```config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }```to config/environments/development.rb

# Create Post and send to Telegram
```rails g scaffold Article title content:text --no-help --no-assets --no-controller-specs --no-view-specs --no-test-framework --no-jbuilder```
```rails g mailer TelegramMailer```

# Export pdf
```
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
```
```rails generate wicked_pdf```

Add
```
WickedPdf.config ||= {}
WickedPdf.config.merge!({
  layout: "pdf",
  orientation: "Portrait",
  page_size: "A4"
})
```
to config/initializers/wicked_pdf.rb
Create template: ```app/views/articles/show.pdf.erb```
Create main template: ```app/views/layouts/pdf.html.erb```




---
# NOTE
Rollback
```bin/rails destroy scaffold Post```
