This is the finance tracker app
```
$ rails _6.1.4.1_ new finance_media                                 
```

[Devise](https://github.com/heartcombo/devise#starting-with-rails)

```rb
# Gembilfe:
gem 'devise'
```
```
# Run in terminal:
$ rails generate devise:install
$ rails generate devise User
$ rails routes | grep users
$ rails db:migrate
```

## Bootstrap
```
$ yarn add bootstrap@4.3.1 jquery popper.js
```
Make sure you are looking at the correct version of bootstrap
[Bootstrap 4.3](https://getbootstrap.com/docs/4.3)

```js
// config/webpack/environment.js
const { environment } = require('@rails/webpacker')

const webpack = require("webpack")

environment.plugins.append("Provide", new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

module.exports = environment
```

```js
// app/javascript/packs/application.js
import "bootstrap"
```

```css
/* app/assets/stylesheets/application.css */
/*
 *
 *= require bootstrap
 *= require_tree .
 *= require_self
 */
```

### Style Devise Forms

[Devise Bootstrap Views](https://github.com/hisea/devise-bootstrap-views) is used to style Devise forms with bootstrap
```rb
gem 'devise-bootstrap-views', '~> 1.0'
```
```
$ bundle install
$ rails generate devise:views:bootstrap_templates
$ rails s
```

### API
[IEX Cloud](https://iexcloud.io/) </br>
[iex-ruby-client](https://github.com/dblock/iex-ruby-client)
```rb
# Gemfile
gem 'iex-ruby-client'
```
```
$ bundle install
$ rails c
```

```rb
client = IEX::Api::Client.new(
  publishable_token: '#{API_key}',
  secret_token: '#{API_key}',
  endpoint: 'https://cloud.sandbox.com/v1'
)
```
## Stock Model
```
$ rails generate model Stock ticker:string name:string last_price:decimal
$ rails db:migrate
```

## Save API Keys
```
$ EDITOR="code --wait" rails credentials:edit
```
```rb
# app/models/stock.rb
class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
    publishable_token: Rails.application.credentials.iex_client[:publishable_token],
    secret_token: Rails.application.credentials.iex_client[:secret_token],
    endpoint: Rails.application.credentials.iex_client[:dev_endpoint])
    client.price(ticker_symbol)
  end

end
```