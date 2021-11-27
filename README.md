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
