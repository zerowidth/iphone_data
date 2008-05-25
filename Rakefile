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
PROJ.url = 'http://github.com/aniero/iphone_data'
PROJ.version = IPhoneData.version
PROJ.rubyforge.name = ''

PROJ.spec.opts << '--color --format specdoc'

depend_on "plist", ">= 3.0.0"
depend_on "sqlite3-ruby", ">= 1.2.1"
depend_on "main", ">= 2.8.0"
