import wollok.game.*

class Pregunta {
	const property respuestaCorrecta
	const property respuestasIncorrectas
	const property respuestas = (respuestaCorrecta + respuestasIncorrectas).sortedBy({x, y => x.opcion().letra() < y.opcion().letra()}) 
	const property position = game.at(7,13)
	var property text 
	method mostrarPregunta (){
		game.addVisual(self)
		self.respuestas().forEach({x => x.mostrarse()})
	}
	method responder(letra){
		if (letra == respuestaCorrecta.head().opcion().letra()){
			game.addVisual(acierto)
		} else game.addVisual(error)
	}
}

class Resultado {
	var property text
	var property position = game.center()
}

object generador {
	method preguntasGeneradas (){
		
	}
}

class Preguntas {
	var property preguntas
	 
}

class Mostrable {
	method mostrarse(){
		game.addVisual(self)
	}
}

class Respuesta inherits Mostrable {
    const property opcion 
    const property position = opcion.position()
    var property text 
}


class Opcion {
	const property position
	const property letra
}

object marley {
	const property image = "Marley.png"
	const property position = game.at(0,15)
	method iniciar(){
	game.addVisual(self)
	}
}

const tomas = new Respuesta (opcion = opA, text = "tomas")
const carlos = new Respuesta (opcion = opB, text = "carlos") 

const opA = new Opcion (letra = "a", position = game.at(7,8))
const opB = new Opcion (letra = "b", position = game.at(14,8))

const pregP = new Pregunta (respuestaCorrecta = [tomas], respuestasIncorrectas = [carlos], text = "Como me llamo?")

const acierto = new Resultado (text = "Correcto")
const error = new Resultado (text = "Incorrecto") 

const nivel1 = new Preguntas (preguntas = [])
const nivel2 = new Preguntas (preguntas = [])
const nivel3 = new Preguntas (preguntas = [])