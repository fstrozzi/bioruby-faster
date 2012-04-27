# create Rakefile for shared library compilation

require File.join("..",File.dirname(__FILE__),"lib/bio/faster/library")

path = File.expand_path(File.dirname(__FILE__))
ext = Bio::Faster::Library.lib_extension

flags = ""
compile = ""
if ext == "so" then
  flags = "-shared -Wl,-soname,libfaster.so -lz"
  compile = " -fPIC"
elsif ext == "dylib" then
  flags = "-bundle -undefined dynamic_lookup -flat_namespace -lz"
end


File.open(File.join(path,"Rakefile"),"w") do |rakefile|
  rakefile.write <<-RAKE
require 'rake/clean'

source = %w(faster.c)

CLEAN.include('*.o')
SRC = FileList.new(source)
OBJ_SRC = SRC.ext('o')

rule '.o' => '.c' do |t|
  sh "gcc#{compile} -std=c99 -c -g -Wall -O2 "+t.source+" -o "+t.name
end

task :compile_lib => OBJ_SRC do
  sh "gcc #{flags} -std=c99 "+OBJ_SRC.join(" ")+" -o libfaster.#{ext}"
end

task :default => [:compile_lib, :clean]

  RAKE

end