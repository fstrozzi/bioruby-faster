
#
# Copyright(C) 2012 Francesco Strozzi <francesco.strozzi@gmail.com>
#

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
             :stream, :pointer,
             :line, :pointer,
             :bad_chars, :pointer
    end

    attach_function :fastQ_iterator, [Record], :int

    def self.parse_fastq(file)
        record = Record.new
        record[:filename] = FFI::MemoryPointer.from_string(file)
        while (ret = Bio::Faster.fastQ_iterator(record)) == 1
          yield [record[:id].read_string,record[:seq].read_string, record[:quality].read_string]
        end
        if ret == -1
          raise RuntimeError, "Bad formatted FastQ file!"
        end
    end

  end
end