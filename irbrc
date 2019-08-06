# script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
# rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
# irb_standalone_running = !script_console_running && !rails_running

require 'irb/ext/save-history'
require 'irb/completion'
# require 'pry'

# load File.dirname(__FILE__) + '/.railsrc' if script_console_running

if defined? ::Pry
  Pry.config.pager = false
  Pry.start
  exit
end

def find_me
  User.find_by_email("joshua@opencounter.com")
end
alias :x :exit
alias :r :require
alias :me :find_me
