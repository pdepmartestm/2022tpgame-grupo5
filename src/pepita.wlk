import wollok.game.*
import visuales.*

object partida {
	var property terminado = false
	var property preguntaActual 
	var property errores = 0
	var property resultado
	method iniciar(){
		if (terminado){
		self.reiniciar()
		terminado = false
		} else {
		generador.preguntasGeneradas()
		marley.position(game.at(1,15))
		plantilla.image("image.jpg")
		fogata.iniciar()
	    logo.iniciar()
		self.mostrarPregunta()
		}
	}
	method mostrarPregunta (){
	if(preguntasSeleccionadas.preguntas() != [] && errores < 3){	
	preguntaActual = preguntasSeleccionadas.preguntas().head()	
	preguntaActual.mostrarse()
	preguntaActual.respuestas().forEach({x => x.mostrarse()})
	} else self.evaluarResultado()
	}
	method responder(letra){
	if (letra == preguntaActual.respuestaCorrecta().head().opcion().letra()){
	resultado = acierto
	} else {
		resultado = error
		errores ++ 
		marley.bajar(4)
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
		terminado = true
	}
	method usarPoder (poder){
		if(poder.sinUsar()){
			poder.efecto()
		}
	}
	method reiniciar(){
		plantilla.image("millonario.jpg")
		marley.position(game.center())
		game.removeVisual(fogata)
		game.removeVisual(logo)
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
	preguntasSeleccionadas.preguntas(([nivel3.preguntas().anyOne()] + preguntasSeleccionadas.preguntas()))
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
class Pregunta inherits Mostrable{
	const property respuestaCorrecta
	const property respuestasIncorrectas
	var property respuestas = (respuestaCorrecta + respuestasIncorrectas).sortedBy({x, y => x.opcion().letra() < y.opcion().letra()}) 
	const property position = game.at(11,13)
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
    method textColor() = "FF00FF"
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
	method textColor() = "FFFFFF"
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
	const property textos = ["Un error lo tiene cualquiera", "Me estoy empezando a asustar", "Me quemo!"]
	const property image = "Marley.png"
	var property position = game.center()
	method iniciar(){
	game.addVisual(self)
	}
	method bajar(n){
		position = position.down(n)
		game.say(self, textos.take(partida.errores()).last())
	}
	method introduccion(){
		game.schedule(3000, { game.say(self, "Bienvenido a quien quiere ser millonario!") })
    	game.schedule(6000, { game.say(self, "Responderas preguntas y ganaras plata") })
    	game.schedule(9000, { game.say(self, "Pero si pierdes me quemo") })
    	game.schedule(12000, { game.say(self, "Presiona espacio para empezar") })
	}
}

const acierto = new Resultado (text = "Correcto!")
const error = new Resultado (text = "Incorrecto!") 
const derrota = new Resultado (text = "Perdiste!") 
const victoria = new Resultado (text = "Ganaste!") 

const opA = new Opcion (letra = "a", position = game.at(7,8))
const opB = new Opcion (letra = "b", position = game.at(14,8))
const opC = new Opcion (letra = "c", position = game.at(7,5))
const opD = new Opcion (letra = "d", position = game.at(14,5))

const nivel1 = new Preguntas (preguntas = [preg1,preg2,preg3,preg4])
const nivel2 = new Preguntas (preguntas = [preg5,preg6,preg7])
const nivel3 = new Preguntas (preguntas = [preg8,preg9,preg10,preg11])

const preguntasSeleccionadas = new Preguntas (preguntas = [])
// Nivel 1 

const preg1 = new Pregunta (respuestaCorrecta = [r11], respuestasIncorrectas = [r12], text = "¿De qué país es originario el queso brie?")
const r11 = new Respuesta (opcion = opA, text = "Francia")
const r12 = new Respuesta (opcion = opB, text = "Suiza") 

const preg2 = new Pregunta (respuestaCorrecta = [r21], respuestasIncorrectas = [r22], text = "¿Qué fruto seco lleva en su interior un Ferrero Rocher?")
const r21 = new Respuesta (opcion = opA, text = "Avellana")
const r22 = new Respuesta (opcion = opB, text = "Almendra")  

const preg3 = new Pregunta (respuestaCorrecta = [r32], respuestasIncorrectas = [r31], text = "¿Cuántas válvulas tiene un corazón humano?")
const r31 = new Respuesta (opcion = opA, text = "2")
const r32 = new Respuesta (opcion = opB, text = "4") 

const preg4 = new Pregunta (respuestaCorrecta = [r42], respuestasIncorrectas = [r41], text = "¿Cuántos elementos forman la Tabla Periódica?")
const r41 = new Respuesta (opcion = opA, text = "112")
const r42 = new Respuesta (opcion = opB, text = "118") 

// Nivel 2

const preg5 = new Pregunta (respuestaCorrecta = [r53], respuestasIncorrectas = [r51,r52], text = "¿De qué película es el príncipe azul?")
const r51 = new Respuesta (opcion = opA, text = "Sirenita")
const r52 = new Respuesta (opcion = opB, text = "Bella Durmiente") 
const r53 = new Respuesta (opcion = opC, text = "Cenicienta") 

const preg6 = new Pregunta (respuestaCorrecta = [r61], respuestasIncorrectas = [r62,r63], text = "¿De qué país es Justin Biber?")
const r61 = new Respuesta (opcion = opA, text = "Canada")
const r62 = new Respuesta (opcion = opB, text = "USA") 
const r63 = new Respuesta (opcion = opC, text = "Francia")

const preg7 = new Pregunta (respuestaCorrecta = [r71], respuestasIncorrectas = [r72,r73], text = "¿Quién pintó la Mona Lisa?")
const r71 = new Respuesta (opcion = opA, text = "Da Vinci") 
const r72 = new Respuesta (opcion = opB, text = "Picasso") 
const r73 = new Respuesta (opcion = opC, text = "Dali") 

// Nivel 3

const preg8 = new Pregunta (respuestaCorrecta = [r84], respuestasIncorrectas = [r81,r82,r83], text = "¿Qué planeta es el que se encuentra más cerca del Sol?")
const r81 = new Respuesta (opcion = opA, text = "Urano")
const r82 = new Respuesta (opcion = opB, text = "Saturno") 
const r83 = new Respuesta (opcion = opC, text = "Marte") 
const r84 = new Respuesta (opcion = opD, text = "Mercurio") 

const preg9 = new Pregunta (respuestaCorrecta = [r91], respuestasIncorrectas = [r92,r93,r94], text = "¿A cuántos kilómetros equivale una milla?")
const r91 = new Respuesta (opcion = opA, text = "1.6")
const r92 = new Respuesta (opcion = opB, text = "1.8") 
const r93 = new Respuesta (opcion = opC, text = "2.0") 
const r94 = new Respuesta (opcion = opD, text = "2.2") 

const preg10 = new Pregunta (respuestaCorrecta = [r102], respuestasIncorrectas = [r101,r103,r104], text = "¿De dónde es originario el mojito?")
const r101 = new Respuesta (opcion = opA, text = "Brasil")
const r102 = new Respuesta (opcion = opB, text = "Cuba") 
const r103 = new Respuesta (opcion = opC, text = "Colombia") 
const r104 = new Respuesta (opcion = opD, text = "Venezuela") 

const preg11 = new Pregunta (respuestaCorrecta = [r113], respuestasIncorrectas = [r111,r112,r114], text = "¿Cuántos lados tiene un heptadecágono?")
const r111 = new Respuesta (opcion = opA, text = "15")
const r112 = new Respuesta (opcion = opB, text = "16") 
const r113 = new Respuesta (opcion = opC, text = "17") 
const r114 = new Respuesta (opcion = opD, text = "18") 
