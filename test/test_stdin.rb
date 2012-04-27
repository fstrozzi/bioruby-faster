require File.join(File.dirname(File.dirname(__FILE__)),"spec","helper")

stream = Bio::Faster.new :stdin
stream.each_record do |seq|
	print seq.to_s+"\n"
end

