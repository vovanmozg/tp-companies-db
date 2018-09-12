# doewnloa /tmp http://download.companieshouse.gov.uk/BasicCompanyDataAsOneFile-2018-09-01.zip
# unzip
# csv parse

require 'csv'

class CompaniesImporter
  def initialize(model)
    @model = model
  end

  def process
    import
  end

  def fetch_snapshot
    require 'open-uri'
    url = 'http://download.companieshouse.gov.uk/BasicCompanyDataAsOneFile-2018-09-01.zip'

    open('tmp/1', 'wb') do |file|
      file << open(url).read
    end
  end

  def unzip

  end

  def csv_line_to_hash(line, headers)

  end


  def import
    #whitelist = ['CompanyName', 'CompanyNumber', 'CompanyCategory']
    batch_size = 10000
    counter = 0
    companies = []
    @model.delete_all

    CSV.foreach('tmp/BasicCompanyDataAsOneFile-2018-09-01.csv', headers: true) do |row|
      company = {}
      row.headers.each do |key|
        line_to_hash = lambda do |name, value|
          first, rest = name.split('.', 2)
          { first.strip.to_sym => rest.nil? ? value : line_to_hash.call(rest, value) }
        end
        company.deep_merge!(line_to_hash.call(key.underscore, row[key]))
      end

      companies << company

      if counter == 0
        counter = batch_size
        p "insert_many: #{companies.count}"
        @model.collection.insert_many(companies)
        companies = []
      end

      counter -= 1
    end
  end
end


