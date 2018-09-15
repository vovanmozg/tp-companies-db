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
    unzip
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

  def prepare_to_insert(row)
    data = row.headers.map do |k|
      new_key = k.strip.tr('.', '_').underscore.to_sym
      new_key = '_id' if new_key == :company_number
      [new_key, row[k]]
    end

    data = data.to_h
    data.merge(
        tags: [
            data[:company_name][0],
            data[:company_name][0..1],
            data[:company_name][0..2]
        ]
    )
  end

  def import
    start = Time.now

    CSV.foreach(@csv_path, headers: true) do |row|
      company = @model.new(prepare_to_insert(row))
      company.upsert
    end

    finish = Time.now
    p '--- TIME ---'
    p finish - start
  end
end


