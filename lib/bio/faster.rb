
module Bio

  module Faster

    extend FFI::Library

    ffi_lib Bio::Faster::Library.load

    class Record < FFI::Struct
      layout :id, :pointer,
             :comment, :pointer,
             :seq, :pointer,
             :quality, :pointer,
             :filename, :pointer,
             :stream, :pointer
    end

    attach_function :fastQ_iterator, [Record], :int

    def self.parse_fastq(file)
        seq = Record.new
        seq[:filename] = FFI::MemoryPointer.from_string(file)
        Bio::Faster.fastQ_iterator seq
        puts "From Ruby:"
        puts seq[:id].read_string
        puts seq[:seq].read_string
        puts seq[:quality].read_string
    end

  end
end