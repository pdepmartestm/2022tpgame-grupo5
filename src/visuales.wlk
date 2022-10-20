import wollok.game.*

object plantilla {
	var property image = "millonario.jpg"
	const property position = game.origin()
	method iniciar(){
	game.width(20)
	game.height(20)
	game.addVisual(self)
	}
}

object disponibilidad {
	method text() = "Poderes disponibles: "
	
	method textColor() = "98FB98"
	
	method position() = game.at(7,19)
	
	method mostrarse() {
	game.addVisual(self)
	}
	
	method borrarse() {
	game.removeVisual(self)
	}
}