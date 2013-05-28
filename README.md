<a href="http://designmodo.com/shop/?u=223" target="_blank"><img src="http://designmodo.com/img/affiliate/flatui_468_60.jpg" border="0"/></a>

This gem integrates Designmodo's Flat UI Pro Design for Twitter Bootstrap into the Rails 3 and 4 Asset Pipeline.

You **must** purchase and download a licensed copy to use this gem (none of the assets are packaged per Flat UI Pro license).  You may do so by clicking the above image (full disclosure: affiliate link).

The version major and minor should match the Flat UI Pro version.  Anything after the major or minor are gem versions.

## Installation
First install and configure dependencies: [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails) and [jquery-ui-rails](https://github.com/joliss/jquery-ui-rails) .

Add this line to your application's Gemfile:

    gem 'designmodo-flatuipro-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install designmodo-flatuipro-rails

One **must** run the install generator after install *and* after update of designmodo-flatuipro-rails gem:

    $ rails generate flatuipro:install <Flat UI Pro Directory>

## Usage
After running the install generator, all assets should be setup.

This gem will detect whether you chose less/static for the twitter-bootstrap-rails install and generate either less/css flatuipro files accordingly.

## Thanks
Any and all donations are much appreciated =).

Gittip: [reflection](https://www.gittip.com/reflection/)

Designmodo Affiliate Link (image above)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
