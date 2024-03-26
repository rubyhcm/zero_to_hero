# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:items] = 2 # items per page
# Better user experience handled automatically
require 'pagy/extras/overflow'
# load la o ngay trang cuoi cung
Pagy::DEFAULT[:overflow] = :last_page
require "pagy/extras/bootstrap"

# Pagy::I18n.load(locale: :en)
