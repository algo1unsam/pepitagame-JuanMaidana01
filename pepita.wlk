import extras.*
import wollok.game.*

object pepita {

	var property energia = 100
	var property enemigo = silvestre //Lo hago más objetoso, en cambio de querer cambiar el enemgio no modifico el método.
	var property position = game.origin()

	method image() {
		return if (self.estaEnElNido()) "pepita-grande.png" 
		else if ( game.onSameCell(self.position(), enemigo.position()) or self.energia()<=0 ) "pepita-gris.png" 
		else "pepita.png"
	}

	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		if ( !self.estaCansada() ) {
			self.vola(position.distance(nuevaPosicion))
			position = nuevaPosicion
		}
		else { game.stop() } //Termino el juego porque pepita se quedó sin energía.
	}

	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}
	
	method estaEnElSuelo() {
		return position.y() == 0 
	}

	method caer() {
		if ( self.estaEnElAire() ) { position = position.down(1) }
	}

	method estaEnElAire() { // Para facilitar la lectura del código en caer().
		return (!self.estaEnElNido() and !self.estaEnElSuelo())
	}
}