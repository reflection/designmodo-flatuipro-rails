require 'fileutils'
require 'designmodo/flatuipro/rails/version'

gem_dir = File.expand_path("../..", __FILE__)
gems_dir = File.expand_path("..", gem_dir)

versions = Designmodo::Flatuipro::Rails::VERSION.split('.')
flatuipro_version = versions[0..-2].join('.')
gem_version = versions.last.to_i

# Copy assets from previous gem if same Flat UI Pro version
Gem.post_install do |installer|
  return unless gem_version > 0
  
  prev_gem_version = gem_version - 1

  vendor_dir = File.join(gems_dir, "designmodo-flatuipro-rails-#{flatuipro_version}.#{prev_gem_version}", "vendor")

  # If previous version is for the same Flat UI Pro
  if File.exists?(vendor_dir)
    FileUtils.cp_r vendor_dir, gem_dir, :verbose => true
  end
end