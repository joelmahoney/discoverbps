require 'json'

root_url        = "https://apps.mybps.org/WebServiceDiscoverBPSv1.10/Schools.svc/"
school_year     = "2014"

task :update_schools => [
  :update_basic_info,
  :update_awards,
  :update_description,
  :update_facilities,
  :update_grades,
  :update_hours,
  :update_languages,
  :update_partners,
  :update_photos,
  :update_sports
]

task :update_basic_info => :environment do
  school_endpoint = "GetSchool?schyear=#{school_year}"
  school_url      = "#{root_url}#{school_endpoint}"

  puts "===> Updating each school's basic info from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_basic_info = Faraday.new(
      :url => "#{school_url}&sch=#{x.bps_id}",
      :ssl => {:version => :SSLv3}).get.body

    if api_basic_info.present?
      x.update_attributes(api_basic_info: MultiJson.load(api_basic_info, :symbolize_keys => true))
    end
  end

end

task :update_awards => :environment do
  awards_endpoint = "GetSchoolAwards?schyear=#{school_year}"
  awards_url      = "#{root_url}#{awards_endpoint}"

  puts "===> Updating each school's awards from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_awards = Faraday.new(
      :url => "#{awards_url}&sch=#{x.bps_id}&TranslationLanguage=",
      :ssl => {:version => :SSLv3}).get.body

    if api_awards.present?
      x.update_attributes(api_awards: MultiJson.load(api_awards, :symbolize_keys => true))
    end
  end
end

task :update_description => :environment do
  desc_endpoint = "GetSchoolDescriptions?schyear=#{school_year}"
  desc_url      = "#{root_url}#{desc_endpoint}"

  puts "===> Updating each school's description from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_description = Faraday.new(
      :url => "#{desc_url}&sch=#{x.bps_id}&TranslationLanguage=",
      :ssl => {:version => :SSLv3}).get.body

    if api_description.present?
      x.update_attributes(api_description: MultiJson.load(api_description, :symbolize_keys => true))
    end
  end
end

task :update_facilities => :environment do
  facilities_endpoint = "GetSchoolFacilities?schyear=#{school_year}"
  facilities_url      = "#{root_url}#{facilities_endpoint}"

  puts "===> Updating each school's facilities from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_facilities = Faraday.new(
      :url => "#{facilities_url}&sch=#{x.bps_id}",
      :ssl => {:version => :SSLv3}).get.body

    if api_facilities.present?
      x.update_attributes(api_facilities: MultiJson.load(api_facilities, :symbolize_keys => true))
    end
  end
end

task :update_grades => :environment do
  grades_endpoint = "GetSchoolGrades?schyear=#{school_year}"
  grades_url      = "#{root_url}#{grades_endpoint}"

  puts "===> Updating each school's grades from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    unless x.bps_id == "4670"
      api_grades = Faraday.new(
        :url => "#{grades_url}&sch=#{x.bps_id}",
        :ssl => {:version => :SSLv3}).get.body
    end

    if api_grades.present?
      x.update_attributes(api_grades: MultiJson.load(api_grades, :symbolize_keys => true))
    end
  end
end

task :update_hours => :environment do
  hours_endpoint  = "GetSchoolHours?schyear=#{school_year}"
  hours_url       = "#{root_url}#{hours_endpoint}"

  puts "===> Updating each school's hours from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_hours = Faraday.new(
      :url => "#{hours_url}&sch=#{x.bps_id}&TranslationLanguage=",
      :ssl => {:version => :SSLv3}).get.body

    if api_hours.present?
      x.update_attributes(api_hours: MultiJson.load(api_hours, :symbolize_keys => true))
    end
  end
end

task :update_languages => :environment do
  languages_endpoint = "GetSchoolLanguages?schyear=#{school_year}"
  languages_url      = "#{root_url}#{languages_endpoint}"

  puts "===> Updating each school's languages from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_languages = Faraday.new(
      :url => "#{languages_url}&sch=#{x.bps_id}",
      :ssl => {:version => :SSLv3}).get.body

    if api_languages.present?
      x.update_attributes(api_languages: MultiJson.load(api_languages, :symbolize_keys => true))
    end
  end
end

task :update_partners => :environment do
  partners_endpoint = "GetSchoolPartners?schyear=#{school_year}"
  partners_url      = "#{root_url}#{partners_endpoint}"

  puts "===> Updating each school's partners from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_partners = Faraday.new(
      :url => "#{partners_url}&sch=#{x.bps_id}&TranslationLanguage=",
      :ssl => {:version => :SSLv3}).get.body

    if api_partners.present?
      x.update_attributes(api_partners: MultiJson.load(api_partners, :symbolize_keys => true))
    end
  end
end

task :update_photos => :environment do
  photos_endpoint = "GetSchoolPhotos?schyear=#{school_year}"
  photos_url      = "#{root_url}#{photos_endpoint}"

  puts "===> Updating each school's photos from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_photos = Faraday.new(
      :url => "#{photos_url}&sch=#{x.bps_id}",
      :ssl => {:version => :SSLv3}).get.body

    if api_photos.present?
      x.update_attributes(api_photos: MultiJson.load(api_photos, :symbolize_keys => true))
    end
  end
end

task :update_sports => :environment do
  sports_endpoint = "GetSchoolSports?schyear=#{school_year}"
  sports_url      = "#{root_url}#{sports_endpoint}"

  puts "===> Updating each school's sports from API..."
  puts "===> Hang tight. This will take a few minutes..."
  School.all.each do |x|
    api_sports = Faraday.new(
      :url => "#{sports_url}&sch=#{x.bps_id}",
      :ssl => {:version => :SSLv3}).get.body

    if api_sports.present?
      x.update_attributes(api_sports: MultiJson.load(api_sports, :symbolize_keys => true))
    end
  end
end
