import wollok.game.*

object partida {
	var property preguntaActual 
	var property errores = 0
	var property resultado
	method mostrarPregunta (){
	if(preguntasSeleccionadas.preguntas() != [] && errores < 3){	
	preguntaActual = preguntasSeleccionadas.preguntas().head()	
	game.addVisual(preguntaActual)
	preguntaActual.respuestas().forEach({x => x.mostrarse()})
	} else self.evaluarResultado()
	}
	method responder(letra){
	if (letra == preguntaActual.respuestaCorrecta().head().opcion().letra()){
	resultado = acierto
	} else {
		resultado = error
		errores ++ 
	}
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
	method usarPoder (poder){
		if(poder.sinUsar()){
			poder.efecto()
		}
	}
}
class Poder {
	var property sinUsar = true
}
object poder1 inherits Poder {
	method efecto (){
		if (partida.preguntaActual().respuestas().size() > 2){
		partida.preguntaActual().borrarse()
		partida.preguntaActual().respuestas((partida.preguntaActual().respuestaCorrecta() + [partida.preguntaActual().respuestasIncorrectas().anyOne()]))
		partida.mostrarPregunta()
		sinUsar = false
		}
	}
}
object poder2 inherits Poder {
	method efecto (){
	partida.preguntaActual().borrarse()
	preguntasSeleccionadas.preguntas().remove(partida.preguntaActual())
	preguntasSeleccionadas.preguntas().add(nivel3.preguntas().anyOne())
	partida.mostrarPregunta()	
	sinUsar = false
	}
}
object poder3 inherits Poder {
	method efecto(){
		partida.responder(partida.preguntaActual().respuestaCorrecta().head().opcion().letra())
		sinUsar = false
	}
}
class Pregunta {
	const property respuestaCorrecta
	const property respuestasIncorrectas
	var property respuestas = (respuestaCorrecta + respuestasIncorrectas).sortedBy({x, y => x.opcion().letra() < y.opcion().letra()}) 
	const property position = game.at(7,13)
	var property text 
    method borrarse (){
    	game.removeVisual(self)
    	respuestas.forEach({x => game.removeVisual(x)})
    }
    method borrarRespuesta (){
    	respuestasIncorrectas.remove(respuestasIncorrectas.anyOne())
    }
}

class Resultado {
	var property text
	var property position = game.at(11,10)
	    method borrarse (){
    	game.removeVisual(self)
    }
}

object generador {
	var property pregunta 
	method preguntasGeneradas (){
		4.times({x => self.seleccionarPregunta(nivel1)})
		3.times({x => self.seleccionarPregunta(nivel2)})
		3.times({x => self.seleccionarPregunta(nivel3)})
	}
	method seleccionarPregunta (nivel){
		pregunta = nivel.preguntas().anyOne()
		preguntasSeleccionadas.preguntas().add(pregunta)
		nivel.preguntas().remove(pregunta)
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
	const property position = game.at(1,15)
	method iniciar(){
	game.addVisual(self)
	}
}

const tomas = new Respuesta (opcion = opA, text = "tomas")
const carlos = new Respuesta (opcion = opB, text = "carlos") 

const opA = new Opcion (letra = "a", position = game.at(7,8))
const opB = new Opcion (letra = "b", position = game.at(14,8))
const opC = new Opcion (letra = "c", position = game.at(7,4))
const opD = new Opcion (letra = "d", position = game.at(14,4))

const pregP = new Pregunta (respuestaCorrecta = [tomas], respuestasIncorrectas = [carlos], text = "Como me llamo?")

const acierto = new Resultado (text = "Correcto!")
const error = new Resultado (text = "Incorrecto!") 
const derrota = new Resultado (text = "Perdiste!") 
const victoria = new Resultado (text = "Ganaste!") 

const nivel1 = new Preguntas (preguntas = [])
const nivel2 = new Preguntas (preguntas = [])
const nivel3 = new Preguntas (preguntas = [preg3])

const preguntasSeleccionadas = new Preguntas (preguntas = [preg1, pregP, preg2])

const preg1 = new Pregunta (respuestaCorrecta = [r13], respuestasIncorrectas = [r11,r12,r14], text = "¿De qué película es el príncipe azul?")
const r11 = new Respuesta (opcion = opA, text = "Sirenita")
const r12 = new Respuesta (opcion = opB, text = "Bella Durmiente") 
const r13 = new Respuesta (opcion = opC, text = "Cenicienta") 
const r14 = new Respuesta (opcion = opD, text = "Mulán") 

const preg2 = new Pregunta (respuestaCorrecta = [r22], respuestasIncorrectas = [r21,r23,r24], text = "¿De qué país vino Justin Biber?")
const r21 = new Respuesta (opcion = opA, text = "Canada")
const r22 = new Respuesta (opcion = opB, text = "USA") 
const r23 = new Respuesta (opcion = opC, text = "Francia") 
const r24 = new Respuesta (opcion = opD, text = "Inglaterra")

const preg3 = new Pregunta (respuestaCorrecta = [r33], respuestasIncorrectas = [r31,r32,r34], text = "aaa")
const r31 = new Respuesta (opcion = opA, text = "incorrecta")
const r32 = new Respuesta (opcion = opB, text = "incorrecta") 
const r33 = new Respuesta (opcion = opC, text = "correcta") 
const r34 = new Respuesta (opcion = opD, text = "incorrecta") 