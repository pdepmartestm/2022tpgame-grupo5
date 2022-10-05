import wollok.game.*

object plantilla {
	const property image = "image.jpg"
	const property position = game.origin()
	method iniciar(){
	game.width(20)
	game.height(20)
	game.addVisual(self)
	}
}

object fogata {
	const property image = "fogata.png"
	const property position = game.at(0,0)
	method iniciar(){
	game.addVisual(self)
	}
}
