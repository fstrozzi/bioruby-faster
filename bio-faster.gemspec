# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bio-faster"
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francesco Strozzi"]
  s.date = "2012-06-13"
  s.description = "A fast parser for FastQ files"
  s.email = "francesco.strozzi@gmail.com"
  s.extensions = ["ext/mkrf_conf.rb"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bio-faster.gemspec",
    "ext/faster.c",
    "ext/mkrf_conf.rb",
    "lib/bio-faster.rb",
    "lib/bio/faster.rb",
    "lib/bio/faster/library.rb",
    "spec/fastq_error_spec.rb",
    "spec/helper.rb",
    "spec/parser_spec.rb",
    "test/data/errors/error_header.fastq",
    "test/data/errors/error_long_qual.fastq",
    "test/data/errors/error_qual_del.fastq",
    "test/data/errors/error_qual_escape.fastq",
    "test/data/errors/error_qual_null.fastq",
    "test/data/errors/error_qual_space.fastq",
    "test/data/errors/error_qual_tab.fastq",
    "test/data/errors/error_qual_unit_sep.fastq",
    "test/data/errors/error_qual_vtab.fastq",
    "test/data/errors/error_spaces.fastq",
    "test/data/errors/error_tabs.fastq",
    "test/data/errors/error_trunc_at_qual.fastq",
    "test/data/errors/error_trunc_at_seq.fastq",
    "test/data/errors/error_trunc_in_qual.fastq",
    "test/data/errors/error_trunc_in_seq.fastq",
    "test/data/formats/illumina_full_range_as_illumina.fastq",
    "test/data/formats/illumina_full_range_as_sanger.fastq",
    "test/data/formats/illumina_full_range_as_solexa.fastq",
    "test/data/formats/illumina_full_range_original_illumina.fastq",
    "test/data/formats/issue_2.fastq",
    "test/data/formats/longreads_as_illumina.fastq",
    "test/data/formats/longreads_as_sanger.fastq",
    "test/data/formats/longreads_as_solexa.fastq",
    "test/data/formats/misc_dna_as_illumina.fastq",
    "test/data/formats/misc_dna_as_sanger.fastq",
    "test/data/formats/misc_dna_as_solexa.fastq",
    "test/data/formats/misc_dna_original_sanger.fastq",
    "test/data/formats/misc_rna_as_illumina.fastq",
    "test/data/formats/misc_rna_as_sanger.fastq",
    "test/data/formats/misc_rna_as_solexa.fastq",
    "test/data/formats/misc_rna_original_sanger.fastq",
    "test/data/formats/sanger_full_range_as_illumina.fastq",
    "test/data/formats/sanger_full_range_as_sanger.fastq",
    "test/data/formats/sanger_full_range_as_solexa.fastq",
    "test/data/formats/sanger_full_range_original_sanger.fastq",
    "test/data/formats/solexa_full_range_as_illumina.fastq",
    "test/data/formats/solexa_full_range_as_sanger.fastq",
    "test/data/formats/solexa_full_range_as_solexa.fastq",
    "test/data/formats/solexa_full_range_original_solexa.fastq",
    "test/data/formats/wrapping_as_illumina.fastq",
    "test/data/formats/wrapping_as_sanger.fastq",
    "test/data/formats/wrapping_as_solexa.fastq",
    "test/test_stdin.rb"
  ]
  s.homepage = "http://github.com/fstrozzi/bioruby-faster"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A fast parser for FastQ files"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<bio>, [">= 1.4.2"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<ffi>, [">= 0"])
    else
      s.add_dependency(%q<ffi>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<bio>, [">= 1.4.2"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<ffi>, [">= 0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<bio>, [">= 1.4.2"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<ffi>, [">= 0"])
  end
end

