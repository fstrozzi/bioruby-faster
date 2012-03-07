require 'helper'

describe Bio::Faster do
  
  describe "#parse_fastq" do

    it "should read a FastQ file returning each sequence" do
      Bio::Faster.parse_fastq(File.join(TEST_DATA,"sample.fastq"))
    end

  end

  
end