require 'whois'
require 'whois-parser'
require 'byebug'
ofile = File.open("details2.txt", "w")
File.open("website1.txt", "r") { |file|
	file.each_line{ |line|
		begin
			line = line.gsub(/https?:\/\//,"")
			record = Whois.whois(line.chomp)
			ofile.write(line)
			count_registrant = 0
			record.to_s.each_line { |l| 
			if (l =~ /Registrant/)
				count_registrant += 1
			  if(count_registrant == 2)
					registrant_name = l.gsub(/Registrant Name:/,"")
				end
				if(count_registrant == 3)
					organization_name = l.gsub(/Registrant Organization:/,"")
				end
				if(count_registrant == 6)
          registrant_state = l.gsub(/Registrant State\/Province:/,"")
				end
				if(count_registrant == 8)
					registrant_country = l.gsub(/Registrant Country:/,"")
				end
				if(count_registrant == 11)
					registrant_email = l.gsub(/Registrant Email:/,"")
				end
			end
			}
			record.to_s.each_line { |l| 
				if (l =~ /Admin/)
					puts l
				sleep(1)
				end
			}
			record.to_s.each_line { |l| 
				if (l =~ /Tech/)
					puts l
				sleep(1)
				end
			}
			ofile.write("\n")
			rescue => e
			puts e
		end
	}
}
ofile.close

