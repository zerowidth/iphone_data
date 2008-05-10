# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'iphone_sms'

task :default => 'spec:run'

PROJ.name = 'iphone_sms'
PROJ.authors = 'FIXME (who is writing this software)'
PROJ.email = 'FIXME (your e-mail)'
PROJ.url = 'FIXME (project homepage)'
PROJ.rubyforge.name = 'iphone_sms'

PROJ.spec.opts << '--color'

# EOF
