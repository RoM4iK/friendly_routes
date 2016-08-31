# Friendly Routes
Friendly Routes creates DSL for creating rails routes with human friendly URLs

[![Code Climate](https://codeclimate.com/github/RoM4iK/friendly_routes/badges/gpa.svg)](https://codeclimate.com/github/RoM4iK/friendly_routes)
[![Build Status](https://travis-ci.org/RoM4iK/friendly_routes.svg?branch=master)](https://travis-ci.org/RoM4iK/friendly_routes)
## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'friendly_routes'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install friendly_routes
```
## Usage example

```ruby
# config/routes.rb
dummies_route = FriendlyRoutes::Route.new(:get, '/', controller: :dummies, action: :index)
dummies_route.boolean(:free, true: :free, false: :paid)
dummies_route.collection(:category_id, Category, :title)
friendly_url_for dummies_route

# app/controllers/dummies_controller.rb
class DummiesController < ApplicationController
  before_action :parse_friendly_routes, only: [:index]
  def index
  end
end

#  Categories:
#  <Category id: 1, title: "lorem">
#  <Category id: 2, title: "ipsum">


# GET "/free/lorem" - { free: true, category_id: 1}
# GET "/free/ipsum" - { free: true, category_id: 2}
# GET "/paid/lorem" - { free: false, category_id: 1}
# GET "/paid/ipsum" - { free: false, category_id: 2}
```

## Configuration
### Routes

1. Create new route, pass **method**, **path**, **controller name**, and **action** to it.
```ruby
dummies_route = FriendlyRoutes::Route.new(:get, '/', controller: :dummies, action: :index)
```
2. Create route params. *Note: params in route will be accepted in creation order*

Boolean param, pass **name**, and hash with **true** and **false** keys.
```ruby
dummies_route.boolean(:discount, true: :true_condition, false: :false_condition)
```

collection param, pass **name**, **collection**, and **attribute** keys.
```ruby
dummies_route.collection(:categories, Category.where(active: true), :title)
```
3. Initialize route wih `friendly_url_for`
```ruby
friendly_url_for dummies_route
```

### Controllers
Simply call `parse_friendly_routes` before controller action to parse params.
```ruby
before_action :parse_friendly_routes, only: [:index]
```

## Contributing
Feel free to contribute into this repository by creating pull requests.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
