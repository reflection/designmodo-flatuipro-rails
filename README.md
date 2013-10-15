<a href="http://designmodo.com/shop/?u=223" target="_blank"><img src="http://designmodo.com/img/affiliate/flatui_468_60.jpg" border="0"/></a>

This gem integrates Designmodo's Flat UI Pro Design for Twitter Bootstrap 3 into the Rails 3 and 4 Asset Pipeline.

You **must** purchase and download a licensed copy to use this gem (none of the assets are packaged per Flat UI Pro license).  You may do so by clicking the above image (full disclosure: affiliate link).

The version major and minors should match the Flat UI Pro version.  Anything after these are gem versions.

## Installation
First install and configure dependencies: [bootstrap-on-rails](https://github.com/jasontorres/bootstrap-on-rails) and [jquery-ui-rails](https://github.com/joliss/jquery-ui-rails) .

Add this line to your application's Gemfile:

    gem 'designmodo-flatuipro-rails', '~> 1.2.1.0.branch'

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

## Thanks
If you haven't bought it already, please use my Designmodo Affiliate Link (image above)

Thanks [@jehughes](https://github.com/jehughes) for the blog post that inspired me to stop being lazy and write the demo page generator =)

## Changes
#### 1.2.2.0.branch
* Detect Flat-UI-Pro-1.2.2 directory
* Everything else seems to still work =)
#### 1.2.1.0.branch
* Git branch (flatuipro-1.2) and gem release for people who want to use Bootstrap 3
* Rails bootstrap gem changed: _twitter-bootstrap-rails_ -> _bootstrap-on-rails_

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
