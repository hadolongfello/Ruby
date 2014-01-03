### CAR FINDER ###
#
# Launch file from command line
#

APP_ROOT = File.dirname(__FILE__)

#require "#{APP_ROOT}/lib/guide"
#require File.join(APP_ROOT, 'lib', 'guide.rb')
#require File.join(APP_ROOT, 'lib', 'guide')

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'guide'

guide = Guide.new('cars.txt')
guide.launch!