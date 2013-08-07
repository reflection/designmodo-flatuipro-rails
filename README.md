<a href="http://designmodo.com/shop/?u=223" target="_blank"><img src="http://designmodo.com/img/affiliate/flatui_468_60.jpg" border="0"/></a>

This gem integrates Designmodo's Flat UI Pro Design for Twitter Bootstrap into the Rails 3 and 4 Asset Pipeline.

You **must** purchase and download a licensed copy to use this gem (none of the assets are packaged per Flat UI Pro license).  You may do so by clicking the above image (full disclosure: affiliate link).

The version major and minors should match the Flat UI Pro version.  Anything after these are gem versions.

## Installation
First install and configure dependencies: [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails) and [jquery-ui-rails](https://github.com/joliss/jquery-ui-rails) .

Add this line to your application's Gemfile:

    gem 'designmodo-flatuipro-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install designmodo-flatuipro-rails

### Install Generator
One **must** run this after install *and* after update of designmodo-flatuipro-rails gem:

    $ rails generate flatuipro:install <Flat UI Pro Directory>

### Demo Page Generator
If you want to integrate the demo page:

    $ rails generate flatuipro:demo

The demo generator creates a 'flatuipro\_demo' controller with a default 'flatuipro\_demo/index' route.

IMPORTANT: After deciding which components to use from the demo page, make sure to only include the corresponding less/css and js that you need from the flatuipro-demo.* files

## Usage
After running the install generator, all assets should be setup.

This gem will detect whether you chose less/static for the twitter-bootstrap-rails install and generate either less/css flatuipro files accordingly.

## Thanks
If you haven't bought it already, please use my Designmodo Affiliate Link (image above)

Thanks [@jehughes](https://github.com/jehughes) for the blog post that inspired me to stop being lazy and write the demo page generator =)

## Changes
#### 1.1.3.1
* Move directory from vendor -> app because of rails 4 (https://github.com/rails/rails/pull/7968)
* Ensure all assets are precompiled correctly if so desired

#### 1.1.3.0
* Support Flat UI Pro 1.1.3
* Add new 'flatuipro:demo' generator to integrate demo page

#### 1.1.1
* Minor documentation changes to include Rails 4 compatibility

#### 1.1.0
* Initial commit

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
