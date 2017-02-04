#!/usr/bin/env ruby
require 'fileutils'

require_relative "affinity_designer/app"
require_relative "affinity_designer/export"
require_relative "affinity_designer/settings"

def check_dependencies!
  raise "cliclick is required (run `brew install cliclick`)" unless dependency_exists?("cliclick")
end

def dependency_exists?(cmd)
  `which #{cmd}`.length != 0
end

check_dependencies!
