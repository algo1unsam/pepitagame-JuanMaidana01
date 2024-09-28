import extras.*
import wollok.game.*

object pepita {

	var property energia = 100
	var property enemigo = silvestre //Lo hago más objetoso, en caso de querer cambiar el enemgio no modifico el método.
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
			self.verificarPosicion()
		}
		else {
			game.say(self, "¡PERDÍ!") 
			extras.timer.esperar() } //Termino el juego porque pepita se quedó sin energía.
	}

	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}

	method estaEnElAire() { // Para facilitar la lectura del código en caer().
		return (!self.estaEnElNido() and !self.estaEnElSuelo())
	}
	
	method estaEnElSuelo() {
		return position.y() == 0 
	}

	method caer() {
		if ( self.estaEnElAire() ) { position = position.down(1) }
	}

	method verificarPosicion() {
		position = game.at(position.x().min(9).max(0), position.y().min(9).max(0)) 
		// Funciona, queda menos feo la parte de niveles.wlk (por como lo había hecho antes con if's, solo que ahora al intentar
		// salirse del límite se gasta comida, cosa que antes no pasaba porque no se llegaba a mover directamente).

		// La esquina superior derecha es (9, 9).
	}
}