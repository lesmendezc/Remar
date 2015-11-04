class EgresosController < ApplicationController
  before_action :set_egreso, only: [:show, :edit, :update, :destroy]

  # GET /egresos
  # GET /egresos.json
  def index
    #@egresos = Egreso.all
    @palabra = ''
    @palabra = params[:palabra]
    @egresos = Egreso.where("concepto LIKE ?", "%#{@palabra}%")
  end

  # GET /egresos/1
  # GET /egresos/1.json
  def activo
    @egreso.activo
      respond_to do |format|
      format.html { redirect_to egresos_url }
      format.json { head :no_content }
    end
  end

  def buscar_entre_fechas
    if params[:fecha_inicio] != "" || params[:fecha_fin] != ""
      fecha_inicio = Date.parse(params[:fecha_inicio])
      fecha_fin = Date.parse(params[:fecha_fin])
      @egresos = Egreso.where(:created_at => fecha_inicio.beginning_of_day..fecha_fin.end_of_day)
      render 'index'
    end
  end

  def show
  end

  # GET /egresos/new
  def new
    @egreso = Egreso.new
  end

  # GET /egresos/1/edit
  def edit
  end

  # POST /egresos
  # POST /egresos.json
  def create
    @egreso = Egreso.new(egreso_params)
    @egreso.estado = 'Activo'

    if @egreso.save
        flash[:success] = 'Egreso creado exitosamente'
        redirect_to '/egresos'
      else
        render action: "new"
      end
  end

  # PATCH/PUT /egresos/1
  # PATCH/PUT /egresos/1.json
  def update
    @egreso = Egreso.find(params[:id])
      if @egreso.update(egreso_params)
        flash[:success] = "Egreso actualizado exitosamente"
        redirect_to '/egresos'
      else
        render action: "edit"
      end
  end

  # DELETE /egresos/1
  # DELETE /egresos/1.json
  def destroy
    @egreso.destroy
    respond_to do |format|
      format.html { redirect_to egresos_url, notice: 'Egreso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_egreso
      @egreso = Egreso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def egreso_params
      params.require(:egreso).permit(:estado, :monto, :fecha, :concepto)
    end
end
