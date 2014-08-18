module SchoolData

	def self.update_basic_info!(school_id=nil)
		school_endpoint = "GetSchool?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{school_endpoint}&sch=#{school.bps_id}",
				:ssl => {:version => :SSLv3}).get.body

			if api_response.present?
				# Use .first to store as a hash instead of a hash inside an array
      	# Alternatively, you can store as an array, but then you have to call
      	# api_basic_info.first in all partials that need to access hash values
				hash = MultiJson.load(api_response, :symbolize_keys => true).first

				school.update_attributes(name: hash[:schname_23], latitude: hash[:Latitude], longitude: hash[:Longitude], api_basic_info: hash)
				puts "********** done updating basic info for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchool"
			end
		end
	end

	def self.update_awards!(school_id=nil)
		awards_endpoint = "GetSchoolAwards?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{awards_endpoint}&sch=#{school.bps_id}&TranslationLanguage=",
				:ssl => {:version => :SSLv3}).get.body

			if api_response.present?
				array = MultiJson.load(api_response, :symbolize_keys => true)

				school.update_attributes(api_awards: array)
				puts "********** done updating awards for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchoolAwards"
			end
		end
	end

	def self.update_descriptions!(school_id=nil)
  	desc_endpoint = "GetSchoolDescriptions?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{desc_endpoint}&sch=#{school.bps_id}&TranslationLanguage=",
				:ssl => {:version => :SSLv3}).get.body

			if api_response.present?
				# Use .first to store as a hash instead of a hash inside an array
      	# Alternatively, you can store as an array, but then you have to call
      	# api_description.first in all partials that need to access hash values
				hash = MultiJson.load(api_response, :symbolize_keys => true).first

				school.update_attributes(api_description: hash)
				puts "********** done updating descriptions for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchoolDescriptions"
			end
		end
	end

	def self.update_facilities!(school_id=nil)
		facilities_endpoint = "GetSchoolFacilities?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{facilities_endpoint}&sch=#{school.bps_id}",
				:ssl => {:version => :SSLv3}).get.body

			if api_response.present?
				# Use .first to store as a hash instead of a hash inside an array
      	# Alternatively, you can store as an array, but then you have to call
      	# api_facilities.first in all partials that need to access hash values
				hash = MultiJson.load(api_response, :symbolize_keys => true).first

				school.update_attributes(api_facilities: hash)
				puts "********** done updating facilities for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchoolFacilities"
			end
		end
	end

	def self.update_grades!(school_id=nil)
		grades_endpoint = "GetSchoolGrades?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			unless school.bps_id == "4670"
				# There's something wrong with this API request when id = 4670
				# The only thing unique about this school that I could find
				# is that it does not have an entry for <rc></rc>. This should
				# be reported to the API developers.
				api_response = Faraday.new(
					:url => "#{BPS_API_URL}#{grades_endpoint}&sch=#{school.bps_id}",
					:ssl => {:version => :SSLv3}).get.body

				if api_response.present?
					array = MultiJson.load(api_response, :symbolize_keys => true)

					school.update_attributes(api_grades: array)
					puts "********** done updating grades for school #{school.bps_id}"
				else
					puts "********** API response not present for #{school.bps_id} on GetSchoolGrades"
				end
			end
		end
	end

	def self.update_hours!(school_id=nil)
		hours_endpoint  = "GetSchoolHours?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{hours_endpoint}&sch=#{school.bps_id}&TranslationLanguage=",
				:ssl => {:version => :SSLv3}).get.body
			if api_response.present?
				# Use .first to store as a hash instead of a hash inside an array
      	# Alternatively, you can store as an array, but then you have to call
      	# api_facilities.first in all partials that need to access hash values
				hash = MultiJson.load(api_response, :symbolize_keys => true).first

				school.update_attributes(api_hours: hash)
				puts "********** done updating hours for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchoolHours"
			end
		end
	end

	def self.update_languages!(school_id=nil)
		languages_endpoint = "GetSchoolLanguages?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{languages_endpoint}&sch=#{school.bps_id}",
				:ssl => {:version => :SSLv3}).get.body

			if api_response.present?
				array = MultiJson.load(api_response, :symbolize_keys => true)

				school.update_attributes(api_languages: array)
				puts "********** done updating languages for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchoolLanguages"
			end
		end
	end

	def self.update_partners!(school_id=nil)
		partners_endpoint = "GetSchoolPartners?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{partners_endpoint}&sch=#{school.bps_id}&TranslationLanguage=",
				:ssl => {:version => :SSLv3}).get.body

			if api_response.present?
				array = MultiJson.load(api_response, :symbolize_keys => true)

				school.update_attributes(api_partners: array)
				puts "********** done updating partners for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchoolPartners"
			end
		end
	end

	def self.update_photos!(school_id=nil)
		photos_endpoint = "GetSchoolPhotos?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{photos_endpoint}&sch=#{school.bps_id}",
				:ssl => {:version => :SSLv3}).get.body

			if api_response.present?
				array = MultiJson.load(api_response, :symbolize_keys => true)

				school.update_attributes(api_photos: array)
				puts "********** done updating photos for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchoolPhotos"
			end
		end
	end

	def self.update_sports!(school_id=nil)
		sports_endpoint = "GetSchoolSports?schyear=#{SCHOOL_YEAR}"

		if school_id.present?
			schools = School.where(id: school_id)
		else
			schools = School.all
		end

		schools.each do |school|
			api_response = Faraday.new(
				:url => "#{BPS_API_URL}#{sports_endpoint}&sch=#{school.bps_id}",
				:ssl => {:version => :SSLv3}).get.body

			if api_response.present?
				# Use .first to store as a hash instead of a hash inside an array
      	# Alternatively, you can store as an array, but then you have to call
      	# api_facilities.first in all partials that need to access hash values
				hash = MultiJson.load(api_response, :symbolize_keys => true).first

				school.update_attributes(api_sports: hash)
				puts "********** done updating sports for school #{school.bps_id}"
			else
				puts "********** API response not present for #{school.bps_id} on GetSchoolSports"
			end
		end
	end
end