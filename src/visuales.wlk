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

object fogata {
	const property image = "fogata.png"
	const property position = game.at(0,1)
	method iniciar(){
	game.addVisual(self)
	}
}

object logo {
	const property image = "logo.png"
	const property position = game.at(0,9)
	method iniciar(){
	game.addVisual(self)
	}
}