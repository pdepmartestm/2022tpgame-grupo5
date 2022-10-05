import wollok.game.*

class Pregunta {
	/*const property respuestaCorrecta
	const property respuestasIncorrectas
	const property respuestas = [respuestaCorrecta + respuestasIncorrectas].sortedBy({x, y => x.opcion().letra() < y.opcion().letra()}) */
	const property respuestas 
	const property position = game.at(15,15)
	method text() = "¡Pepita!"
	method mostrarPregunta (){
		game.addVisual(self)
		self.respuestas().forEach({x => x.mostrarse()})
	}
}

class Mostrable {
	method mostrarse(){
		game.addVisual(self)
	}
}

class Respuesta inherits Mostrable {
    const property opcion 
    const property position
    method text() = "¡Pepita!" 
}

class Texto inherits Mostrable {
    const property position 
    method text() = "¡Pepita!"
}

class Opcion {
	const property letra 
}

const tomas = new Respuesta (opcion = opA, position = game.at(10,12))
const carlos = new Respuesta (opcion = opB, position = game.at(15,12)) 

const opA = new Opcion (letra = "a")
const opB = new Opcion (letra = "b")

const prueba = new Texto (position = game.at(10,15))

const pregP = new Pregunta (respuestas = [tomas,carlos])

