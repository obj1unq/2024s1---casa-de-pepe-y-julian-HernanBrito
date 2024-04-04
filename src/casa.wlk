
object casaDePepeYJulian {
	const viveresNecesarios = 40
	var cantidadDeViveres = 50
	var montoReparacion = 0
	var cuentaBancaria = cuentaCorriente
	var estrategiaDeAhorro = full
	
	method mantenimiento(){
		estrategiaDeAhorro.mantenimiento(self)
	}
	
	method agregarViveresFaltantes(){
		cantidadDeViveres += self.viveresFaltantes()
	}
	
	method cantidadDeViveres(_cantidadViveres){
		cantidadDeViveres = _cantidadViveres
	}
	
	method agregarViveres(cantidad){
		cantidadDeViveres += cantidad
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
	
	method montoReparacion(){
		return montoReparacion
	}
	
	method reparar(){
		self.descontarGastosDeReparacion()
		montoReparacion = 0
	}
	
	method descontarGastosDeReparacion(){
		cuentaBancaria.extraer(self.saldoDeLaCuenta() - self.montoReparacion())
	}
	
	method pagarViveres(valor){
		cuentaBancaria.extraer(valor)
	}

	method casaEnOrden(){
		return (cantidadDeViveres > viveresNecesarios) && (self.montoReparacion() == 0)
	}
	
	method cuentaBancaria(){
		return cuentaBancaria
	}
	
	method cuentaBancaria(_cuentaBancaria){
		cuentaBancaria = _cuentaBancaria
	}
	
	method estrategiaDeAhorro(){
		return estrategiaDeAhorro
	}
	
	method estrategiaDeAhorro(_estrategiaDeAhorro){
		estrategiaDeAhorro = _estrategiaDeAhorro
	}
	
	method saldoDeLaCuenta(){
		return cuentaBancaria.saldo()
	}
	
	method viveresFaltantes(){
		return ( viveresNecesarios - self.cantidadDeViveres() )
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

//estrategias de ahorro
object full {
	const calidadDeVivere = 5
	
	method mantenimiento(casa){
		if(casa.casaEnOrden()){
			casa.cantidadDeViveres(100)
			self.cobrarViveres(casa , 100)
		}
		else{
			casa.agregarViveres(40)
			self.cobrarViveres(casa , 40)
		}
		
		self.cubirReparacionesSiEsPosible(casa)
	}
	//en caso que la cuenta que tenga asociada la casa no tenga los fondos suficientes
	//quedara en negativo
	method cobrarViveres(casa , cantidad){
		casa.pagarViveres(cantidad * calidadDeVivere)
	}
	
	method cubirReparacionesSiEsPosible(casa){
		if (casa.saldoDeLaCuenta() > casa.montoReparacion() + 1000){
			casa.reparar()
		}
	}
}

object minimoEIndispensable{
	
	var calidadDeVivere = 5
	
	
	method mantenimiento(casa){
		self.cobrarViveres(casa , casa.viveresFaltantes())
		casa.agregarViveresFaltantes()
	}	
	
	method calidadDeVivere(){
		return calidadDeVivere
	}
	
	method calidadDeVivere(_calidadDeVivere){
		calidadDeVivere = _calidadDeVivere
	}
	
	method cobrarViveres(casa , cantidad){
		casa.pagarViveres(cantidad * calidadDeVivere)
	}
}

//si se podriar modelar otra casa la cual tendria que entender (montoReparacion() , saldoDeLaCuenta() que tiene asociada
//a la casa , viveresFaltantes() , agregarViveresFaltantes(), casaEnOrden , reparar() etc para poder lograr llamar a un
//mantenimiento
