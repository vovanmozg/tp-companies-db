class ImportCompaniesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    importer = CompaniesImporter.new(Company)
    importer.process
  end
end
