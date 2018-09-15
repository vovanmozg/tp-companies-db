require 'csv'
require 'open-uri'

# Import companies
class CompaniesImporter
  def initialize(model)
    @snapshot_site = 'http://download.companieshouse.gov.uk'
    @model = model
  end

  def process
    fetch_snapshot
    #unzip
    @csv_path = "/app/tmp/BasicCompanyDataAsOneFile-2018-09-01.csv"
    import
  end

  def snapshot_name
    return @snapshot_name if @snapshot_name

    html = open("#{@snapshot_site}/en_output.html").read
    match = /<a href="(BasicCompanyDataAsOneFile-\d\d\d\d-\d\d-\d\d.zip)">/
                .match(html)
    @snapshot_name = match && match[1]
  end

  def fetch_snapshot(force = false)
    @zip_file_path = "/app/tmp/#{snapshot_name}"
    return if !force && File.exist?(@zip_file_path)

    open(@zip_file_path, 'wb') do |file|
      file << open("#{@snapshot_site}/#{snapshot_name}").read
    end
  end

  def unzip
    system("cd /app/tmp && unzip -o #{@zip_file_path}")
    @csv_path = "/app/tmp/#{snapshot_name.gsub(/zip$/, 'csv')}"
  end

  # input: { 'Some.Key' => 'Value' }
  # output: { some: { key: 'Value' } }
  def row_to_hash(row)
    company = {}
    row.headers.each do |key|
      line_to_hash = lambda do |name, value|
        first, rest = name.split('.', 2)
        result_value = rest.nil? ? value : line_to_hash.call(rest, value)
        { first.strip.to_sym => result_value }
      end
      company.deep_merge!(line_to_hash.call(key.underscore, row[key]))
    end
    company
  end

  def prepare_to_insert(row)
    data = row_to_hash(row)
    {
      _id: data[:company_number],
      company_name: data[:company_name],
      data: data
    }
  end

  def import
    counter = 0
    start = Time.now
    CSV.foreach(@csv_path, headers: true) do |row|
      company = @model.new(prepare_to_insert(row))
      company.upsert

      break if (counter += 1) > 40000
    end
    finish = Time.now
    p '--- TIME ---'
    p finish - start

    # return
    # batch_size = 10_000
    # counter = 10_000
    # companies = []
    # @model.delete_all
    #
    # CSV.foreach(@csv_path, headers: true) do |row|
    #   counter -= 1
    #   companies << prepare_to_insert(row)
    #
    #   next if counter > 0
    #
    #   counter = batch_size
    #   p "insert_many: #{companies.count}"
    #   @model.collection.insert_many(companies)
    #   companies = []
    #
    # end
  end
end


