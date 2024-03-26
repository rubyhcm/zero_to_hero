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

# Pagy
```gem 'pagy'
```
```
class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!
end
```
```
module ApplicationHelper
  include Pagy::Frontend
end
```
```
<%== pagy_nav(@pagy) %>
<%== pagy_info(@pagy) %>
<%== pagy_bootstrap_nav(@pagy) %>
```

# Attach avatar
```active_storage:install```
```
  <div>
    <%= form.label :avatar%>
    <%= form.file_field :avatar %>
  </div>
```

# Attach multi images
```  has_many_attached :images```
```
<div>
  <%= form.label :images%>
  <%= form.file_field :images, multiple: true %>
</div>
```

# AWS S3
Auto delete, update item after calling action destroy, update
Delete item on S3 ```@article.images.purge```
```EDITOR=gedit bin/rails credentials:edit```


---
# NOTE
Rollback
```bin/rails destroy scaffold Post```
