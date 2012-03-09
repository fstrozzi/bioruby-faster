module Bio
  class Faster
    class Library

      require 'rbconfig'

      def self.lib_extension
        case RbConfig::CONFIG['host_os']
          when /linux/ then return 'so'
          when /darwin/ then return 'dylib'
          else raise NotImplementedError, "Native library is not available for Windows platform"
        end
      end

      # Load the correct library for the OS system in use
      # @return [String] the absolute path for the filename of the shared library
      # @note this method is called automatically when the module is loaded
      def self.load
        path = File.expand_path File.dirname(__FILE__)
        path.gsub!(/lib\/bio\/faster/,'ext')
        File.join(path,"libfaster.#{self.lib_extension}")
      end

    end
  end
end
