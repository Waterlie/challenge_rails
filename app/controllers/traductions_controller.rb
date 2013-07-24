require 'open-uri'
require 'json'

class TraductionsController < ApplicationController
  before_action :set_traduction, only: [:show, :edit, :update, :destroy]

  def home
    @title = "Home"
    if @traduction.nil?
      @traduction = Traduction.new
    end
  end

  def history
    @title = "History"
    @traductions = Traduction.all.reverse
  end

  def help
    @title = "Help"
  end

  # GET /traductions
  # GET /traductions.json
  def index
    @traductions = Traduction.all
  end

  # GET /traductions/1
  # GET /traductions/1.json
  def show
  end

  # GET /traductions/new
  def new
    @traduction = Traduction.new
  end

  # GET /traductions/1/edit
  def edit
  end

  # POST /traductions
  # POST /traductions.json
  def create
    @traduction = Traduction.new(traduction_params)
    @data = JSON.parse(open(URI.escape("http://translate.google.com/translate_a/t?client=p&q="+@traduction.fr+"&hl=en&sl=fr&tl=en&ie=UTF-8&oe=UTF-8&multires=0")).read)
    @tmp = @data['sentences'][0]['trans']
    @traduction.en = @tmp
    respond_to do |format|
      if @traduction.save
        format.html { redirect_to @traduction, notice: 'Traduction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @traduction }
      else
        format.html { render action: 'home' }
        format.json { render json: @traduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /traductions/1
  # PATCH/PUT /traductions/1.json
  def update
    respond_to do |format|
      if @traduction.update(traduction_params)
        format.html { redirect_to @traduction, notice: 'Traduction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @traduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traductions/1
  # DELETE /traductions/1.json
  def destroy
    @traduction.destroy
    respond_to do |format|
      format.html { redirect_to traductions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_traduction
      @traduction = Traduction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def traduction_params
      params.require(:traduction).permit(:fr, :en)
    end
end
