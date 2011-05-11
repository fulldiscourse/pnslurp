# -*- encoding: utf-8 -*-

require 'bundler'

Gem::Specification.new do |s|
  s.name = %q{pnslurp}
  s.version = "1.0.0"

  s.required_rubygems_version = ">= 1.3.6"
  s.authors = ["Chuck Swanberg"]
  s.date = %q{2011-05-10}
  s.default_executable = %q{slurp}
  s.description = %q{
      Slurps notes from the given file (notes.slurper by default) and creates
      ProjectNotifier notes from them.
    }
  s.email = %q{fd_dev@fulldiscourse.com}
  s.executables = ["slurp"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "bin/slurp",
    "lib/slurper.rb",
    "lib/note.rb",
    "lib/cacert.pem"
  ]
  s.homepage = %q{http://github.com/fulldiscourse/pnslurp}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{takes a formatted note file and puts it on ProjectNotifier}
  # s.test_files = [
  #   "spec/slurper_spec.rb",
  #   "spec/note_spec.rb"
  # ]

  s.add_bundler_dependencies
end
