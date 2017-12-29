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
			count_admin=0
			record.to_s.each_line { |l| 
				if (l =~ /Admin/)               
					count_admin += 1
          if(count_admin == 14)
					email_admin = l.gsub(/Admin Email:/,'')
					puts email_admin
					end
					sleep(1)

				end
			}

			ofile.write("\n")
			#ofile.puts("#{line}, #{contacts.name}, #{contacts.organization}, #{contacts.address}, #{contacts.city}, #{contacts.zip}, #{contacts.state}, #{contacts.country}, #{contacts.country_code}, #{contacts.phone}, #{contacts.fax}, #{contacts.email}, #{contacts.url}, #{contacts.created_on}, #{contacts.updated_on}\n")
			    rescue => e
			          puts "ERROR: #{line}"
			              end
			                }
			                }
			                ofile.close
			                
