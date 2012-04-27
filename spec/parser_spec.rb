require 'helper'

describe Bio::Faster do
  
  describe "#each_record" do

    it "should read a FastQ file returning an array with sequence data" do
      Bio::Faster.new(TEST_DATA+"/formats/illumina_full_range_as_illumina.fastq").each_record do |seq|
        seq.class.should == Array
      end
    end

    it "should handle correctly Phred64 qualities (Solexa)" do
      file = TEST_DATA+"/formats/misc_rna_as_solexa.fastq"
      bioruby_data = []
      Bio::FlatFile.open(File.open(file)).each_entry do |seq|
        seq.format = "fastq-solexa"
        bioruby_data << [seq.entry_id,seq.seq,seq.qualities]
      end
      faster_data = []
      Bio::Faster.new(file, :solexa).each_record do |seq|
        seq[0] = seq[0].split(" ").first
        faster_data << seq
      end
      faster_data.should == bioruby_data
    end
    
    it "should read different FastQ formats" do
      files = Dir.glob(TEST_DATA+"/formats/*.fastq")
      files.each do |file|
        bioruby_data = []
        Bio::FlatFile.open(Bio::Fastq,File.open(file)).each_entry do |seq|
           bioruby_data << [seq.entry_id,seq.seq,seq.qualities]
        end
        faster_data = []
        Bio::Faster.new(file).each_record do |seq|
           seq[0] = seq[0].split(" ").first
           faster_data << seq
        end
        faster_data.should == bioruby_data
      end

    end

    it "can read also gzipped FastQ files" do
      gz_files = Dir.glob(TEST_DATA+"/formats/gzipped/*.fastq.gz").sort
      gz_seq = []
      gz_files.each do |file|
        Bio::Faster.new(file).each_record do |seq|
           gz_seq << seq
        end    
      end
      files = Dir.glob(TEST_DATA+"/formats/gzipped/*.fastq").sort
      norm_seq = []
      files.each do |file|
        Bio::Faster.new(file).each_record do |seq|
           norm_seq << seq
        end    
      end
      gz_seq.should == norm_seq
    end


  end

  
end