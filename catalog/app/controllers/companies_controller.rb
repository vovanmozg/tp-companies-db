class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: ENV['BNAME'], password: ENV['BPASS']

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all.page params[:page]
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /companies/import
  def import
    ImportCompaniesJob.perform_later
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:company_name, :company_number, :reg_address_care_of, :reg_address_po_box, :reg_address_address_line1, :reg_address_address_line2, :reg_address_post_town, :reg_address_county, :reg_address_country, :reg_address_post_code, :company_category, :company_status, :country_of_origin, :dissolution_date, :incorporation_date, :accounts_account_ref_day, :accounts_account_ref_month, :accounts_next_due_date, :accounts_last_made_up_date, :accounts_account_category, :returns_next_due_date, :returns_last_made_up_date, :mortgages_num_mort_charges, :mortgages_num_mort_outstanding, :mortgages_num_mort_part_satisfied, :mortgages_num_mort_satisfied, :sic_code_sic_text_1, :sic_code_sic_text_2, :sic_code_sic_text_3, :sic_code_sic_text_4, :limited_partnerships_num_gen_partners, :limited_partnerships_num_lim_partners, :uri, :previous_name_1_condate, :previous_name_1_company_name, :previous_name_2_condate, :previous_name_2_company_name, :previous_name_3_condate, :previous_name_3_company_name, :previous_name_4_condate, :previous_name_4_company_name, :previous_name_5_condate, :previous_name_5_company_name, :previous_name_6_condate, :previous_name_6_company_name, :previous_name_7_condate, :previous_name_7_company_name, :previous_name_8_condate, :previous_name_8_company_name, :previous_name_9_condate, :previous_name_9_company_name, :previous_name_10_condate, :previous_name_10_company_name, :conf_stmt_next_due_date, :conf_stmt_last_made_up_date)
  end
end
