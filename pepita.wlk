import extras.*
import wollok.game.*

object pepita {

	var property energia = 35
	var property position = game.origin()

	method image() {
		return if (self.estaEnElNido()) "pepita-grande.png" 
		else if ( game.onSameCell(self.position(), extras.silvestre.position()) or self.energia()<=0 ) "pepita-gris.png" 
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
			self.gastarEnergia()
		}
	}

	method gastarEnergia() {
		energia -= 2
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

}

