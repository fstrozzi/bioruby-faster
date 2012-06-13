
#
# Copyright(C) 2012 Francesco Strozzi <francesco.strozzi@gmail.com>
#

module Bio

  class Faster

    extend FFI::Library

    ffi_lib Bio::Faster::Library.load

    attr_accessor :file
    attr_accessor :encoding
    def initialize(file, encoding = :sanger)
        self.file = file
        self.encoding = encoding
    end

    class FastQRecord < FFI::Struct
      layout :id, :pointer,
             :seq, :pointer,
             :quality, :pointer,
             :raw_quality, :pointer,
             :filename, :pointer,
             :stream, :pointer,
             :line, :pointer,
             :bad_chars, :pointer

    end

    attach_function :fastQ_iterator, [FastQRecord, :int], :int

    def each_record(args = {:quality => :int}, &block)
        if self.file == :stdin
          self.file = "stdin"
        elsif !File.exists? self.file
          raise ArgumentError, "File #{self.file} does not exist"
        end
        record = FastQRecord.new
        record[:filename] = FFI::MemoryPointer.from_string self.file
				result = nil

				if args[:quality] == :int
        	scale_factor = nil
        	case self.encoding
          	when :sanger then scale_factor = 33
          	when :solexa then scale_factor = 64
        	end
					result = parse_fastq_with_quality_conversion(record, scale_factor, &block)
				elsif args[:quality] == :raw
					scale_factor = 0
					result = parse_fastq(record, scale_factor, &block)	
				end

				case result
          when -1 then raise RuntimeError, "Bad formatted FastQ file!"
          when -2 then raise RuntimeError, "Sequence or quality is truncated!"
        end


    end

		private
		
		def parse_fastq_with_quality_conversion(record, scale_factor, &block)	
      while (result = Bio::Faster.fastQ_iterator(record,scale_factor)) == 1
         yield [record[:id].read_string,record[:seq].read_string,record[:quality].read_array_of_int(record[:raw_quality].read_string.length)]
       end
			result
		end

		def parse_fastq(record, scale_factor, &block)	
      while (result = Bio::Faster.fastQ_iterator(record,scale_factor)) == 1
         yield [record[:id].read_string,record[:seq].read_string,record[:raw_quality].read_string]
       end
			result
		end

  end
end
