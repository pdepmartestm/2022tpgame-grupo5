import wollok.game.*
import visuales.*
import preguntas.*

object partida {

	var property terminado = false
	var property preguntaActual
	var property errores = 0
	var property resultado
	var property resultadoFinal
	const property preguntasUsadas = []
	var property preguntaAnterior 
	const erroresPermitidos = 3
	const preguntasAResponder = 10
    const poderes = [poder1, poder2, poder3]
    
    method inicio(){
    plantilla.iniciar()
	marley.iniciar()
	marley.introduccion()
    }

	method comenzar() {
		if (terminado) {
			self.reiniciar()
			terminado = false
		} else {
			marley.position(game.at(1, 15))
			plantilla.image("image.jpg")
			self.iniciarPoderes()
			self.mostrarPregunta()
		}
	}

	method mostrarPregunta() {
		if (preguntasUsadas.size() < preguntasAResponder && errores < erroresPermitidos) {
			preguntaActual = generador.generarPregunta()
			preguntasUsadas.add(preguntaActual)
			preguntaActual.mostrarse()
			preguntaActual.respuestas().forEach({ x => x.mostrarse()})
		} else self.evaluarResultado()
	}

	method responder(letra) {
		if (letra == self.letraRespuesta()) {
			resultado = acierto
		} else {
			resultado = error
			errores++
			marley.bajar(4)
		}
		game.addVisual(resultado)
	}

	method siguientePregunta() {
		preguntaActual.borrarse()
		resultado.borrarse()
		self.mostrarPregunta()
	}

	method evaluarResultado() {
		if (preguntasUsadas.size() == preguntasAResponder) {
			resultadoFinal = victoria
		} else if (errores == erroresPermitidos) {
			resultadoFinal = derrota
		}
		game.addVisual(resultadoFinal)
		terminado = true
	}

	method usarPoder(poder) {
		self.preguntaActual().borrarse()
		poder.efecto()
		preguntaActual.mostrarse()
		preguntaActual.respuestas().forEach({ x => x.mostrarse()})
	}

	method reiniciar() {
		errores = 0
		preguntasUsadas.clear()
		disponibilidad.borrarse()
		poderes.forEach({x => x.borrarse()})
		plantilla.image("millonario.jpg")
		marley.position(game.at(9, 5))
		game.removeVisual(resultadoFinal)
		marley.introduccion()
	}

    method nivelesUsables(){
    	return niveles.filter({x => x.maximo() > preguntasUsadas.size()})
    }
    
    method quitarRespuestas(){
    	if (preguntaActual.respuestas().size() > 2){
    	preguntaActual.respuestas((preguntaActual.respuestaCorrecta() + [ preguntaActual.respuestasIncorrectas().anyOne() ]))
    	}
    }
    
    method cambiarPregunta(){
    	preguntaAnterior = preguntaActual
    	preguntaActual = generador.generarPregunta()
    	preguntasUsadas.remove(preguntaAnterior)
    }
    
    method responderBien(){
    	self.responder(self.letraRespuesta())
    }
    
    method iniciarPoderes(){
    	disponibilidad.mostrarse()
    	poderes.forEach({x => game.addVisual(x)})
    }
    method letraRespuesta(){
    	return preguntaActual.respuestaCorrecta().head().opcion().letra()
    }
}

class Poder {
    
	var property sinUsar = true
	
	method textColor() = "98FB98"
	
	method usarse(){
		sinUsar = false
	}
	method efecto(){
		self.efectoParticular()
		self.borrarse()
		self.usarse()
	}
	method borrarse() {
		if (sinUsar){
		game.removeVisual(self)
	    }
	}
	method efectoParticular()
	method position()
	method text()
}

object poder1 inherits Poder {
	override method position() = game.at(10,19)
	
	override method text() = "Poder 1\n Quita respuestas"
	
	override method efectoParticular(){
		partida.quitarRespuestas()
	}

}

object poder2 inherits Poder {
	override method position() = game.at(13,19)
	
	override method text() = "Poder 2\n Cambio de pregunta"

	override method efectoParticular(){
		partida.preguntaActual(generador.generarPregunta())
	}

}

object poder3 inherits Poder {
	
	override method position() = game.at(16,19)
	
	override method text() = "Poder 3\n Responder bien"

	override method efectoParticular(){
		partida.responderBien()
	}

}

class Pregunta inherits Mostrable {

	const property respuestaCorrecta
	const property respuestasIncorrectas
	var property respuestas = (respuestaCorrecta + respuestasIncorrectas).sortedBy({ x , y => x.opcion().letra() < y.opcion().letra() })
	const property position = game.at(11, 13)
	var property text

	method borrarse() {
		game.removeVisual(self)
		respuestas.forEach({ x => game.removeVisual(x)})
	}

	method borrarRespuesta() {
		respuestasIncorrectas.remove(respuestasIncorrectas.anyOne())
	}

}

class Resultado {

	var property text
	var property position = game.at(11, 10)

	method borrarse() {
		game.removeVisual(self)
	}

	method textColor() = "FF00FF"

}

object generador {
    var property pregunta 
    method generarPregunta(){
    	pregunta = self.seleccionarPregunta() 
    	if (self.preguntaSeUso()){
    	return pregunta
    	} else return self.generarPregunta()
    }
    
    method seleccionarPregunta(){
    	return partida.nivelesUsables().head().preguntas().anyOne()
    }
     
    method preguntaSeUso(){
    	return partida.preguntasUsadas().contains(pregunta).negate()
    }
}

class Nivel {

	var property preguntas
    const property maximo
    
}

class Mostrable {

	method textColor() = "FFFFFF"

	method mostrarse() {
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

	const property textos = [ "Un error lo tiene cualquiera", "Me estoy empezando a asustar", "Me quemo!" ]
	const property image = "Marley.png"
	var property position = game.at(9, 5)

	method iniciar() {
		game.addVisual(self)
	}

	method bajar(n) {
		position = position.down(n)
		game.say(self, textos.take(partida.errores()).last())
	}

	method introduccion() {
		game.schedule(1000, { game.say(self, "Bienvenidos a quien quiere ser millonario!")})
		game.schedule(4000, { game.say(self, "Responderas preguntas y ganaras plata")})
		game.schedule(7000, { game.say(self, "Pero si pierdes me quemo")})
		game.schedule(10000, { game.say(self, "Presiona espacio para empezar")})
	}

}