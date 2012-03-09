require 'helper'

describe Bio::Faster do
  
  describe "#parse_fastq" do

    it "should read a FastQ file returning an array with sequence data" do
      Bio::Faster.new(File.join(TEST_DATA,"sample.fastq")).each_record do |seq|
        seq.class.should == Array
      end
    end

    it "should raise an error if the header is wrong" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_header.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a space in the quality string" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_qual_space.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a tab in the quality string" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_qual_tab.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a v-tab in the quality string" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_qual_vtab.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a space in the sequence string" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_spaces.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a tab in the sequence string" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_tabs.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a delete char in the quality string" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_qual_del.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is an escape in the quality string" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_qual_escape.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a unit separator char in the quality string" do
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_qual_unit_sep.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise an error if sequence and quality are truncated or differ in length" do
      puts "Trunctaed at Qual"
      #expect {Bio::Faster.new(File.join(TEST_DATA,"error_trunc_at_qual.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
      #expect {Bio::Faster.new(File.join(TEST_DATA,"error_trunc_at_seq.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_qual_null.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
      expect {Bio::Faster.new(File.join(TEST_DATA,"error_long_qual.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
      #expect {Bio::Faster.new(File.join(TEST_DATA,"error_trunc_in_seq.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)
      #expect {Bio::Faster.new(File.join(TEST_DATA,"error_trunc_in_qual.fastq")).each_record {|seq|}}.to raise_error(RuntimeError)

    end

  end

  
end