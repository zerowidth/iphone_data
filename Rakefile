# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'iphone_data'

task :default => 'spec:run'

PROJ.name = 'iphone_data'
PROJ.authors = 'Nathan Witmer'
PROJ.email = 'nwitmer@gmail.com'
PROJ.url = 'http://github.com'
PROJ.rubyforge.name = 'iphone_data'

PROJ.spec.opts << '--color --format specdoc'

# EOF
