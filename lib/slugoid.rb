require 'slugoid/acts/slugoid'
require 'slugoid/mongoid/criteria'

Mongoid::Document.send(:include, Acts::Slugoid)
