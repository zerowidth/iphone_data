Gem::Specification.new do |s|
  s.name = %q{iphone_data}
  s.version = "0.1.0"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Witmer"]
  s.date = %q{2008-05-11}
  s.default_executable = %q{iphone_data}
  s.description = %q{Script to dump data from an iPhone's sync backup files.}
  s.email = %q{nwitmer@gmail.com}
  s.executables = ["iphone_data"]
  s.extra_rdoc_files = ["History.txt", "README.txt", "bin/iphone_data"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/iphone_data", "lib/iphone_data.rb", "lib/iphone_data/command.rb", "lib/iphone_data/iphone.rb", "lib/iphone_data/sms_message.rb", "spec/iphone_data_spec.rb", "spec/spec_helper.rb", "tasks/ann.rake", "tasks/bones.rake", "tasks/gem.rake", "tasks/manifest.rake", "tasks/notes.rake", "tasks/post_load.rake", "tasks/rdoc.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/test.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/aniero/iphone_data}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{Script to dump data from an iPhone's sync backup files}
end
