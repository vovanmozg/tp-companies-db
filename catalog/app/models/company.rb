class Company
  include Mongoid::Document
  field :company_name, type: String
  field :company_number, type: String
  field :data, type: Hash

  index(company_name: 'text')
end
