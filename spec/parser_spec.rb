require 'helper'

describe Bio::Faster do
  
  describe "#parser" do
  
    it "reads both Fasta and FastQ format files" do
      res = Bio::Faster.parse(File.join(TEST_DATA,"sample.fastq")) {|seq|}
      res.should == true
      res = Bio::Faster.parse(File.join(TEST_DATA,"sample.fasta")) {|seq|}
      res.should == true
    end
    
    it "needs a valid block to parse files" do
      expect { Bio::Faster.parse(File.join(TEST_DATA,"sample.fastq")) }.to raise_error(ArgumentError)
    end
  
    it "throws an error if file does not exists" do
      expect { Bio::Faster.parse(File.join(TEST_DATA,"dummy.fastq")) }.to raise_error(ArgumentError)
    end
    
    it "returns an array with id, comment, sequence and an array with qualities (FastQ only)" do
      Bio::Faster.parse(File.join(TEST_DATA,"sample.fastq")) do |seq| 
        seq.class.should == Array
        seq.size.should == 4
        seq[-1].class.should == Array
      end
      
      Bio::Faster.parse(File.join(TEST_DATA,"sample.fasta")) do |seq| 
        seq.class.should == Array
        seq.size.should == 3
      end
      
    end
    
    it "reads gzipped files" do
      res = Bio::Faster.parse(File.join(TEST_DATA,"sample.fastq")) {|seq|}
      res.should == true
    end
    
    it "parse correctly FastQ files" do
      faster_res = []
      Bio::Faster.parse(File.join(TEST_DATA,"sample.fastq")) {|seq| faster_res << seq}
      faster_res[0][0].should == "HISEQ1:86:D0306ACXX:2:1101:20970:17588"
      faster_res[0][1].should == "1:N:0:CTTGTA"
      faster_res[0][2].should == "CGGTGCTGTTGTTATGCTGATGCTTATTAGTGCAAGTGTAGCTCCTCCGATTAGATGAATTAACAGGTGTCCTGCAGTAATGTTGGCTGTTAGTCGTAC"
      
      faster_res[-1][0].should == "HISEQ1:86:D0306ACXX:2:1101:1411:17830"
      faster_res[-1][1].should == "1:Y:0:CTTGTA"
      faster_res[-1][2].should == "CGGCGGGCGTGGGGAGAGAGCTATGAAGGCCTCAGGGAAGCTTCGAGAGTATAAGGTGTTGGGGTGCTGCCTGCCAACCCCCAAATTCCACACACCACC"
    end
    
    it "parse correctly compressed FastQ files" do
      faster_res = []
      Bio::Faster.parse(File.join(TEST_DATA,"sample.fastq.gz")) {|seq| faster_res << seq}
      faster_res[0][0].should == "HISEQ1:86:D0306ACXX:2:1101:20970:17588"
      faster_res[0][1].should == "1:N:0:CTTGTA"
      faster_res[0][2].should == "CGGTGCTGTTGTTATGCTGATGCTTATTAGTGCAAGTGTAGCTCCTCCGATTAGATGAATTAACAGGTGTCCTGCAGTAATGTTGGCTGTTAGTCGTAC"
      
      faster_res[-1][0].should == "HISEQ1:86:D0306ACXX:2:1101:1411:17830"
      faster_res[-1][1].should == "1:Y:0:CTTGTA"
      faster_res[-1][2].should == "CGGCGGGCGTGGGGAGAGAGCTATGAAGGCCTCAGGGAAGCTTCGAGAGTATAAGGTGTTGGGGTGCTGCCTGCCAACCCCCAAATTCCACACACCACC"
    end
    

    it "parse correctly Fasta files" do
      faster_res = []
      Bio::Faster.parse(File.join(TEST_DATA,"sample.fasta")) {|seq| faster_res << seq}
      faster_res[0][0].should == "seq1"
      faster_res[0][1].should == "comment1"
      faster_res[0][2].should == "AGCAATTTCCCTTTTCCTGTCCTTTTTATAACATTGTGGAGGAAGACGGCAGCATAAAAAGGACAGTATTTGATTAAAAAATGATAAAAATTTTCAAAC"
      
      faster_res[-1][0].should == "seq4"
      faster_res[-1][1].should == "comment4"
      faster_res[-1][2].should == "mgltrrealssiaavggekalkdalavlggps"
    end
  
  
    describe "quality conversion for FastQ files (Sanger/Phred only)" do
    
      it "converts directly quality scores for Illumina 1.8+ FastQ files" do

        bio_quals = []
        # standard Quality conversion as done by BioRuby
        Bio::FlatFile.open(Bio::Fastq,File.open(File.join(TEST_DATA,"sample.fastq"))).each_entry do |seq|
          bio_quals << seq.qualities
        end

        faster_quals = []
        Bio::Faster.parse(File.join(TEST_DATA,"sample.fastq")) do |seq|
          faster_quals << seq[-1]
        end
        faster_quals.should == bio_quals

      end

      it "converts directly quality scores for SFF 454 FastQ files" do

        bio_quals = []
        # standard Quality conversion as done by BioRuby
        Bio::FlatFile.open(Bio::Fastq,File.open(File.join(TEST_DATA,"sff_sample.fastq"))).each_entry do |seq|
          bio_quals << seq.qualities
        end

        faster_quals = []
        Bio::Faster.parse(File.join(TEST_DATA,"sff_sample.fastq")) do |seq|
          faster_quals << seq[-1]
        end
        faster_quals.should == bio_quals

      end
    
    end
  
  end
  
end