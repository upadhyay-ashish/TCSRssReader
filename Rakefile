# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
require 'rubygems'
require 'motion-cocoapods'
require 'nano-store'
require 'motion-pixate'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'TCS RSS'

  app.icons = ["iPhoneIcon_Big", "iPhoneIcon_Medium", "iPhoneIcon_Small"]

  app.resources_dirs = [ 'assets','./resources',]
  # Pixate framework
  app.pixate.framework = 'vendor/PXEngine.framework'
  app.codesign_certificate = ENV['Developer_License'] 
  # Add the pod NanoStore to your project
  app.pods do
    pod 'NanoStore', '~> 2.6.0'
    pod 'REMenu', '~> 1.2.4'
    pod 'XMLReader', '0.0.2'
    pod 'Reachability', '~>2.0.5'
    pod 'MBProgressHUD', '~> 0.6'
  end
end
