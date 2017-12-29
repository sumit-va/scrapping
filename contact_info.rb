require 'rubygems'
require 'open-uri'
require 'csv'

def check_contact(website)
	check = false
	url_last = "contact"
	email = ""
	form_status =  false
	begin
		html_doc = open("#{URI.encode(website.strip!)}/#{url_last}")
		html_doc.read.each_line do |line|
			if line =~ /([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/
				email += $& + ", "
			end
			if line =~ /<form/
				form_status = true
			end
		end
	rescue => e
		if check == true
			check = false
			url_last = "contact"
			puts e
		else
			check = true
			url_last = "contact-us"
			retry
		end
	end

	return email, form_status
end

def check_about(website)
	check = false
	url_last = "about"
	email = ""
	begin
		html_doc = open("#{URI.encode(website.strip!)}/#{url_last}")
		html_doc.read.each_line do |line|
			if line =~ /([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/
				email += $& + ", "
			end
		end
	rescue => e
		if check == true
			check = false
			url_last = "about"
			puts e
		else
			check = true
			url_last = "about-us"
			retry
		end
	end
	return email
end

data = {}
File.open("details.txt", 'wb') do |file|
	File.open('website1.txt').each_line do |website|
		values = check_contact(website)
	  email_ids1 = values[0]
		form_status = values[1]
		email_ids2 = check_about(website)
		data[website] ||= {}
		data[website]["contact"] = email_ids1.to_s
		data[website]["about"] = email_ids2.to_s
		data[website]["contact-form"] = form_status
   file.write(data)
	 file.write("\n")
	end
end

=begin
MetaInfo = Struct.new(:url, :tag, :email_ids) do 
	def initialize(hash = {}) 
		hash.each do |key, value| 
			send("#{key}=", value) 
		end 
	end 
end

data = { "#{url}" => {"tag" => [], "email_id" => []} }

def create_metafile(url, tag, email_ids)
	_metainfo = Metainfo.new(:url => url, :tag => tag, :email_ids => email_ids)
	File.open('/tmp/details.txt', 'wb') { |file| file.write(_metainfo.to_h) }
end
=end
