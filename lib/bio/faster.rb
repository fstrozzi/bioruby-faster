
#
# Copyright(C) 2012 Francesco Strozzi <francesco.strozzi@gmail.com>
#

module Bio

  class Faster

    extend FFI::Library

    ffi_lib Bio::Faster::Library.load

    attr_accessor :file
    def initialize(file)
        self.file = file
    end

    class FastQRecord < FFI::Struct
      layout :id, :pointer,
             :seq, :pointer,
             :quality, :pointer,
             :filename, :pointer,
             :stream, :pointer,
             :line, :pointer,
             :bad_chars, :pointer

    end

    attach_function :fastQ_iterator, [FastQRecord], :int

    def each_record
        record = FastQRecord.new
        record[:filename] = FFI::MemoryPointer.from_string self.file
        while (result = Bio::Faster.fastQ_iterator(record)) == 1
          sequence = [record[:id].read_string,record[:seq].read_string, record[:quality].read_string]
          yield sequence
          #new_record = FastQRecord.new
          #new_record[:stream] = record[:stream]
          #new_record[:line] = record[:line]
          #new_record[:bad_chars] = record[:bad_chars]
          #record = new_record
        end
        case result
          when -1 then raise RuntimeError, "Bad formatted FastQ file!"
          when -2 then raise RuntimeError, "Sequence or quality is truncated!"
        end


    end


  end
end