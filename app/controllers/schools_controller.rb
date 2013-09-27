class SchoolsController < ApplicationController
  # GET /schools
  # GET /schools.json
  def index
    # GET eligible schools
    response = bps_api_connector("https://apps.mybps.org/schooldata/schools.svc/GetSchoolChoices?SchoolYear=2013-2014&Grade=03&StreetNumber=23&Street=Becket+st&ZipCode=02108")
    eligible_schools = response[:List]

    # GET school information
    @schools = []
    eligible_schools.each do |school|
      id = school[:School]
      school_hash = {}
      school_hash[:eligibility] = school

      # bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetTierList")
      # bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/get?SearchToken={TOKEN}")
      # bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetAddressMatches?StreetNumber={STREETNUMBER}&Street={STREET}&ZipCode={ZIPCODE}")
      # bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolChoices?SchoolYear={SCHOOLYEAR}&Grade={GRADE}&StreetNumber={STREETNUMBER}&Street={STREET}&ZipCode={ZIPCODE}")
      # bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolList?schyear=2013")

      school_hash[:basic_info]        = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchool?schyear=2013&sch=#{id}")[0]
      school_hash[:awards]            = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolAwards?schyear=2013&sch=#{id}&TranslationLanguage=")
      school_hash[:description]       = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolDescriptions?schyear=2013&sch=#{id}&TranslationLanguage=")
      school_hash[:facilities]        = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolFacilities?schyear=2013&sch=#{id}")
      school_hash[:grades]            = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolGrades?schyear=2013&sch=#{id}")
      school_hash[:hours]             = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolHours?schyear=2013&sch=#{id}&TranslationLanguage=")
      school_hash[:partners]          = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolPartners?schyear=2013&sch=#{id}&TranslationLanguage=")
      # school_hash[:calendar]          = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolCalendar?schyear=2013&sch=#{id}")
      # school_hash[:extra_curricular]  = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolExtraCurricular?schyear=2013&sch=#{id}&TranslationLanguage=")
      # school_hash[:languages]         = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolLanguages?schyear=2013&sch=#{id}")
      # school_hash[:photos]            = bps_api_connector("https://apps.mybps.org/WebServiceDiscoverBPSDEV/Schools.svc/GetSchoolPhotos?schyear=2013&sch=#{id}")

      @schools << school_hash
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end
  end

  def show
    @school = School.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @school }
    end
  end

  private

  def bps_api_connector(url)
    response = Faraday.new(:url => url, :ssl => {:version => :SSLv3}).get
    if response.body.present?
      MultiJson.load(response.body, :symbolize_keys => true)
    end
  end

end
