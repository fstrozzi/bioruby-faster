require 'mkmf'
extension_name = "faster"
have_library("z")
create_makefile(extension_name)



