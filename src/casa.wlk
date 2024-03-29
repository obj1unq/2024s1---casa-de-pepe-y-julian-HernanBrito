
object casaDePepeYJulian {
	const viveresNecesarios = 40
	var cantidadDeViveres = 50
	var montoReparacion = 0
	
	method cantidadDeViveres(_cantidadViveres){
		cantidadDeViveres = _cantidadViveres
	}
	
	method cantidadDeViveres(){
		return cantidadDeViveres
	}
	
	method hayViveresSuficientes() {
		return self.cantidadDeViveres() >= viveresNecesarios
	}
	
	method romper(valor){
		montoReparacion += valor
	}
	
	method reparaciones(){
		return montoReparacion
	}
	
	method reparar(){
		montoReparacion = 0
	}
	
	method casaEnOrden(){
		return (cantidadDeViveres > viveresNecesarios) && (self.reparaciones() == 0)
	}
	
}

