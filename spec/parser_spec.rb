require 'helper'

describe Bio::Faster do
  
  describe "#parse_fastq" do

    it "should read a FastQ file returning each sequence" do
      Bio::Faster.parse_fastq(File.join(TEST_DATA,"sample.fastq")) do |seq|
        seq.class.should == Array
        p seq
      end

    end

  end

  
end