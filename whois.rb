require 'whois'
require 'whois-parser'
require 'byebug'
require 'csv'

CSV.open('info.csv','w') do |csv|
	csv << ['Website url', 'Registrant_name', 'Organization_name', 'Registrant_state', 'Registrant_country', 'Registrant_email', 'Admin_email']
	File.open("website1.txt", "r") { |file|

		file.each_line { |line|
			begin
				registrant_name = ""
				organization_name = ""
				registrant_state = ""
				registrant_country = ""
				registrant_email = ""
				admin_email = ""

				line = line.gsub(/https?:\/\//,"")
				record = Whois.whois(line.chomp)
				record.to_s.each_line { |l|
					if registrant_name == "" && l =~ /Registrant Name:/
					registrant_name = l.gsub(/Registrant Name:/,"")
					end
					if organization_name == "" && l =~ /Registrant Organization:/
					organization_name = l.gsub(/Registrant Organization:/,"")
					end
					if registrant_state == "" && l=~ /Registrant State\/Province:/
					registrant_state = l.gsub(/Registrant State\/Province:/,"")
					end
					if registrant_country == "" && l=~ /Registrant Country:/
					registrant_country = l.gsub(/Registrant Country:/,"")
					end
					if registrant_email == "" && l=~ /Registrant Email:/
					registrant_email = l.gsub(/Registrant Email:/,"")
					end
					if admin_email == "" && l=~ /Admin Email:/
					admin_email = l.gsub(/Admin Email:/,"")
					end
				}
			rescue => e
				puts e
			end
			puts "okk"
			csv << [line, registrant_name, organization_name, registrant_state, registrant_country, registrant_email, admin_email]
		}
	}
end

