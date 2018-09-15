class Company
  include Mongoid::Document
  field :company_name, type: String
  field :company_number, type: String
  field :reg_address_care_of, type: String
  field :reg_address_po_box, type: String
  field :reg_address_address_line1, type: String
  field :reg_address_address_line2, type: String
  field :reg_address_post_town, type: String
  field :reg_address_county, type: String
  field :reg_address_country, type: String
  field :reg_address_post_code, type: String
  field :company_category, type: String
  field :company_status, type: String
  field :country_of_origin, type: String
  field :dissolution_date, type: String
  field :incorporation_date, type: String
  field :accounts_account_ref_day, type: String
  field :accounts_account_ref_month, type: String
  field :accounts_next_due_date, type: String
  field :accounts_last_made_up_date, type: String
  field :accounts_account_category, type: String
  field :returns_next_due_date, type: String
  field :returns_last_made_up_date, type: String
  field :mortgages_num_mort_charges, type: String
  field :mortgages_num_mort_outstanding, type: String
  field :mortgages_num_mort_part_satisfied, type: String
  field :mortgages_num_mort_satisfied, type: String
  field :sic_code_sic_text_1, type: String
  field :sic_code_sic_text_2, type: String
  field :sic_code_sic_text_3, type: String
  field :sic_code_sic_text_4, type: String
  field :limited_partnerships_num_gen_partners, type: String
  field :limited_partnerships_num_lim_partners, type: String
  field :uri, type: String
  field :previous_name_1_condate, type: String
  field :previous_name_1_company_name, type: String
  field :previous_name_2_condate, type: String
  field :previous_name_2_company_name, type: String
  field :previous_name_3_condate, type: String
  field :previous_name_3_company_name, type: String
  field :previous_name_4_condate, type: String
  field :previous_name_4_company_name, type: String
  field :previous_name_5_condate, type: String
  field :previous_name_5_company_name, type: String
  field :previous_name_6_condate, type: String
  field :previous_name_6_company_name, type: String
  field :previous_name_7_condate, type: String
  field :previous_name_7_company_name, type: String
  field :previous_name_8_condate, type: String
  field :previous_name_8_company_name, type: String
  field :previous_name_9_condate, type: String
  field :previous_name_9_company_name, type: String
  field :previous_name_10_condate, type: String
  field :previous_name_10_company_name, type: String
  field :conf_stmt_next_due_date, type: String
  field :conf_stmt_last_made_up_date, type: String

  field :tags, type: Array

  index({ tags: 1 }, background: true)
  index({ company_name: 1 }, background: true)
end
