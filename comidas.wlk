import wollok.game.*

object manzana {

	method image() = "manzana.png"

	//1, 8
	method position() = game.at(2, 2)

	method energiaQueOtorga() = 40

}

object alpiste {

	method image() = "alpiste.png"

	method position() = game.at(3, 3)

	method energiaQueOtorga() = 70

}

