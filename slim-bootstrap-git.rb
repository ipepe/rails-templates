# New app
# rails new blog -m ~/template.rb
# rails new blog -m http://example.com/template.rb
# Existing app
# bin/rails app:template LOCATION=~/template.rb
# bin/rails app:template LOCATION=http://example.com/template.rb

add_source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap-sass-official'
  gem 'rails-assets-bootstrap-datepicker'
end

gem "slim-rails"

initializer 'slim-templates.rb', <<-Ruby
Rails.application.config.generators do |g|
  g.template_engine :slim
end
Ruby

initializer 'assets.rb', <<-Ruby
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.digest = true
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf .woff2 .png)
Rails.application.config.assets.paths << Rails.root.join('app','assets','fonts/bootstrap-sass-official/assets/fonts/bootstrap')

#NonStupidDigestAssets.whitelist += [/\.(?i:)(?:svg|eot|woff|ttf|otf)$/]
Ruby

after_bundle do
  file '.ruby-version', '2.3.1' 
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
