require 'helper'

describe Bio::Faster do
  
  describe "#parse_fastq" do

    it "should read a FastQ file returning an array with sequence data" do
      Bio::Faster.parse_fastq(File.join(TEST_DATA,"sample.fastq")) do |seq|
        seq.class.should == Array
      end
    end

    it "should raise an error if the header is wrong" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_header.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a space in the quality string" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_qual_space.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a tab in the quality string" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_qual_tab.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a v-tab in the quality string" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_qual_vtab.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a space in the sequence string" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_spaces.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a tab in the sequence string" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_tabs.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a delete char in the quality string" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_qual_del.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is an escape in the quality string" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_qual_escape.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

    it "should raise and error if there is a unit separator char in the quality string" do
      expect {Bio::Faster.parse_fastq(File.join(TEST_DATA,"error_qual_unit_sep.fastq")) {|seq|}}.to raise_error(RuntimeError)
    end

  end

  
end