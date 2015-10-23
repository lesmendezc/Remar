class RecepcionDonativosController < ApplicationController
  before_action :set_recepcion_donativo, only: [:show, :edit, :update, :destroy]

  # GET /recepcion_donativos
  # GET /recepcion_donativos.json
  def index
    @recepcion_donativos = RecepcionDonativo.all.paginate(page: params[:page], per_page: 5).order('fecha DESC')
  end

  # GET /recepcion_donativos/1
  # GET /recepcion_donativos/1.json
  def show
  end

  # GET /recepcion_donativos/new
  def new
    @recepcion_donativo = RecepcionDonativo.new
  end

  # GET /recepcion_donativos/1/edit
  def edit
  end

  # POST /recepcion_donativos
  # POST /recepcion_donativos.json
  def create
    @recepcion_donativo = RecepcionDonativo.new(recepcion_donativo_params)

      if @recepcion_donativo.save
        flash[:success] = 'Recepcion donativo creado exitosamente' 
        redirect_to '/recepcion_donativos'
      else
        render action: "new"
      end
  end

  # PATCH/PUT /recepcion_donativos/1
  # PATCH/PUT /recepcion_donativos/1.json
  def update
      if @recepcion_donativo.update(recepcion_donativo_params)
        flash[:success] = 'Recepcion donativo actualizado exitosamente' 
        redirect_to '/recepcion_donativos'
      else
        render action: "edit"
      end
  end

  # DELETE /recepcion_donativos/1
  # DELETE /recepcion_donativos/1.json
  def destroy
    @recepcion_donativo.destroy
    respond_to do |format|
      format.html { redirect_to recepcion_donativos_url, notice: 'Recepcion donativo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recepcion_donativo
      @recepcion_donativo = RecepcionDonativo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recepcion_donativo_params
      params.require(:recepcion_donativo).permit(:fecha, :nombreDonante, :articulo, :cantidad, :descripcion, :id_voluntario)
    end
end
