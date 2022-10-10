import wollok.game.*

object partida {
	var property preguntaActual 
	var property errores = 0
	var property resultado
	method mostrarPregunta (){
	if(preguntasSeleccionadas.preguntas() != [] || errores < 3){	
	preguntaActual = preguntasSeleccionadas.preguntas().head()	
	game.addVisual(preguntaActual)
	preguntaActual.respuestas().forEach({x => x.mostrarse()})
	} else self.evaluarResultado()
	}
	method responder(letra){
	if (letra == preguntaActual.respuestaCorrecta().head().opcion().letra()){
	resultado = acierto
	} else resultado = error
	game.addVisual(resultado)
	preguntasSeleccionadas.preguntas().remove(preguntaActual)
	}
	method siguientePregunta(){
		preguntaActual.borrarse()
		resultado.borrarse()
		self.mostrarPregunta()
	}
	method evaluarResultado(){
		if(preguntasSeleccionadas.preguntas() == []) {
			game.addVisual(victoria)
		} else if (errores == 3){
			game.addVisual(derrota)
		}
	}
}

class Pregunta {
	const property respuestaCorrecta
	const property respuestasIncorrectas
	const property respuestas = (respuestaCorrecta + respuestasIncorrectas).sortedBy({x, y => x.opcion().letra() < y.opcion().letra()}) 
	const property position = game.at(7,13)
	var property text 
    method borrarse (){
    	game.removeVisual(self)
    	respuestas.forEach({x => game.removeVisual(x)})
    }
}

class Resultado {
	var property text
	var property position = game.at(11,10)
	    method borrarse (){
    	game.removeVisual(self)
    }
}

/*object generador {
	var property pregunta 
	method preguntasGeneradas (){
		4.times({self.seleccionarPregunta(nivel1)})
		3.times({self.seleccionarPregunta(nivel2)})
		3.times({self.seleccionarPregunta(nivel3)})
	}
	method seleccionarPregunta (nivel){
		pregunta = nivel.preguntas().anyOne()
		preguntasSeleccionadas.preguntas().add(pregunta)
		nivel.preguntas().remove(pregunta)
	}
} */

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
	const property position = game.at(1,15)
	method iniciar(){
	game.addVisual(self)
	}
}

const tomas = new Respuesta (opcion = opA, text = "tomas")
const carlos = new Respuesta (opcion = opB, text = "carlos") 

const opA = new Opcion (letra = "a", position = game.at(7,8))
const opB = new Opcion (letra = "b", position = game.at(14,8))

const pregP = new Pregunta (respuestaCorrecta = [tomas], respuestasIncorrectas = [carlos], text = "Como me llamo?")

const acierto = new Resultado (text = "Correcto!")
const error = new Resultado (text = "Incorrecto!") 
const derrota = new Resultado (text = "Perdiste!") 
const victoria = new Resultado (text = "Ganaste!") 

const nivel1 = new Preguntas (preguntas = [])
const nivel2 = new Preguntas (preguntas = [])
const nivel3 = new Preguntas (preguntas = [])

const preguntasSeleccionadas = new Preguntas (preguntas = [pregP])