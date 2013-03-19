# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
require 'rubygems'
require 'motion-cocoapods'
require 'nano-store'
require 'bubble-wrap/all'
require 'motion-pixate'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'TCS'
  app.resources_dirs = [ 'assets','./resources',]
  # Pixate framework
  app.pixate.framework = 'vendor/PXEngine.framework'
  # Add the pod NanoStore to your project
  app.pods do
    pod 'NanoStore', '~> 2.6.0'
    pod 'XMLReader', '0.0.2'
  end
end
