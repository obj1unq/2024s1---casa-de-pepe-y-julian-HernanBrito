
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
	
	method hayQueHacerReparaciones(){
		return montoReparacion > 0
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

//cuentas bancarias

object cuentaCorriente {
	
	var saldo = 0
	
	method depositar(monto){
		saldo += monto
	}
	
	method extraer(monto){
		saldo -=monto
	}
	
	method saldo(){
		return saldo
	}
	
}

object cuentaGastos{
	
	var saldo = 0
	var costoOperacion = 0
	
	method depositar(monto){
		saldo += monto - costoOperacion
	}
	
	method extraer(monto){
		saldo -= monto
	}
	
	method costoOperacion(){
		return costoOperacion
	}
	
	method costoOperacion(_costoOperacion){
		costoOperacion = _costoOperacion
	}
	
	method saldo(){
		return saldo
	}
	
}

object cuentaCombinada{
	
	var cuentaPrimaria = cuentaGastos
	var cuentaSecundaria = cuentaCorriente
	
	method cuentaPrimaria(cuenta){
		cuentaPrimaria = cuenta
	}
	
	method cuentaSecundaria(cuenta){
		cuentaSecundaria = cuenta
	}
	
	method saldo(){
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}
	
	method depositar(monto){
		cuentaPrimaria.depositar(monto)
	}
	
	method extraer(monto){
		if(cuentaPrimaria.saldo() > monto){
			cuentaPrimaria.extraer(monto)
		}
		else{
			cuentaSecundaria.extraer(monto)
		}
	}
	
}


