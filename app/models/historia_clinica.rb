class HistoriaClinica < ActiveRecord::Base
  belongs_to :interno

  validates :enfermedades, presence: {:message => "- Es un campo obligatorio"}
  validates :enfermedades, length: {maximum: 50, too_long: "- %{count} caracteres es la longitud maxima permitida"}
  #validates :enfermedades, format: { with: /\A[a-zA-Z]+\z/, message: "- Solo se aceptan letras"}

  validates :causa_internacion, presence: {:message => "- Es un campo obligatorio"}
  validates :causa_internacion, length: {maximum: 50, too_long: "- %{count} caracteres es la longitud maxima permitida"}
  #validates :causa_internacion, format: { with: /\A[a-zA-Z]+\z/, message: "- Solo se aceptan letras"}

  #validates :observaciones, presence: {:message => "- Es un campo obligatorio"}
  #validates :observaciones, format: { with: /\A[a-zA-Z]+\z/, message: "- Solo se aceptan letras"} 

  def self.search(search)
		if search
			where('interno like ?', "%#{search}%")
		else
			scoped
		end
	end

  def correspondeAinterno(interno)
    parametros = interno.split(' ')
    parametros.each do |parametro|
      if Interno.find(self.interno_id.to_i).nombre.downcase.include?(parametro.downcase)
        return true
      end
    end
    false
  end 
end
