# Telegram

Take Telegram API Token
Connect to an example API: `https://api.telegram.org/bot{{API_TOKEN_KEY}}/getMe`

Send messages: `https://api.telegram.org/bot6379697986:AAGSPiv82e1YWf9UAOsbilii8OvyxQrbGU0/sendMessage?chat_id={{chat_id or group_id}}&text=abc`

# Devise

`rails generate devise:install`

`rails generate devise User`

Add `config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }`to config/environments/development.rb

# Create Post and send to Telegram

`rails g scaffold Article title content:text --no-help --no-assets --no-controller-specs --no-view-specs --no-test-framework --no-jbuilder`

`rails g mailer TelegramMailer`

# Export pdf

```
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
```

`rails generate wicked_pdf`

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

Create template: `app/views/articles/show.pdf.erb`

Create main template: `app/views/layouts/pdf.html.erb`

# Pagy

`gem 'pagy'`

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

`active_storage:install`

```
  <div>
    <%= form.label :avatar%>
    <%= form.file_field :avatar %>
  </div>
```

# Attach multi images

`  has_many_attached :images`

```
<div>
  <%= form.label :images%>
  <%= form.file_field :images, multiple: true %>
</div>
```

# AWS S3

Auto delete, update item after calling action destroy, update

Delete item on S3 `@article.images.purge`

`EDITOR="gedit --wait" bin/rails credentials:edit`

# Validate image

```
gem 'active_storage_validations'
gem 'mini_magick'
gem "image_processing"
```

then add validate to model

On linux, install `sudo apt-get install libvips-tools`

# AWS SES send mail

Config access: `AmazonSesSendingAccess` => IAM

USing AWS SES service to send mail

# Add bootstrap and fix errors + gem 'foreman' to run

#### Add bootstrap: [Boostrap components](https://getbootstrap.com/docs/5.3/getting-started/introduction/)

```
bundle add cssbundling-rails
./bin/rails css:install:bootstrap
```

```
bundle add jsbundling-rails
./bin/rails javascript:install:esbuild
```

#### Fix errors

```
yarn add @hotwired/turbo-rails
```

```
yarn add @hotwired/stimulus
```

```
--- a/app/javascript/application.js
+++ b/app/javascript/application.js
-import "controllers"
+import "./controllers";
```

```
--- a/app/javascript/controllers/index.js
+++ b/app/javascript/controllers/index.js
-import { application } from "controllers/application"
-
-// Eager load all controllers defined in the import map under controllers/**/*_controller
-import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
-eagerLoadControllersFrom("controllers", application)
-
-// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
-// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
-// lazyLoadControllersFrom("controllers", application)
+import { application } from "./application";
```

```
--- a/app/views/layouts/application.html.erb
+++ b/app/views/layouts/application.html.erb
     <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
-    <%= javascript_importmap_tags %>
     <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
   </head>
```

```
--- a/app/assets/config/manifest.js
+++ b/app/assets/config/manifest.js
 //= link_tree ../images
-//= link_tree ../../javascript .js
-//= link_tree ../../../vendor/javascript .js
 //= link_tree ../builds
```

`bundle exec foreman start -f Procfile.dev`

# Action text
```bin/rails action_text:install
```

```has_rich_text :description``` description is new column

# Add font awesome
Add ```gem "font-awesome-sass"``` [Docs](https://docs.fontawesome.com/web/use-with/ruby-on-rails)

```yarn add @fortawesome/fontawesome-free```

In package.json, esbuild add ```--loader:.ttf=file --loader:.woff2=file``` at the end

In application.js, add
```
import "@fortawesome/fontawesome-free/css/all"
import "@fortawesome/fontawesome-free/js/all";
```

Use smth like ```fa-3x ``` for font size.
Use ```fa-spin``` to make any icon spin. Animating Icons











---

# NOTE

Rollback
`bin/rails destroy scaffold Post`

`S3, SES, Cloudformation`

[Create new Rails app](https://railsnew.app/)
