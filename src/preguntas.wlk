import wollok.game.*
import millonario.*

const acierto = new Resultado(text = "Correcto!")

const error = new Resultado(text = "Incorrecto!")

const derrota = new Resultado(text = "Perdiste! \n presiona espacio para reiniciar")

const victoria = new Resultado(text = "Ganaste! \n presiona espacio para reiniciar")

const opA = new Opcion(letra = "a", position = game.at(7, 8))

const opB = new Opcion(letra = "b", position = game.at(14, 8))

const opC = new Opcion(letra = "c", position = game.at(7, 5))

const opD = new Opcion(letra = "d", position = game.at(14, 5))

const nivel1 = new Nivel(preguntas = [ preg1, preg2, preg3, preg4, preg12,preg13,preg14 ], maximo = 4)

const nivel2 = new Nivel(preguntas = [ preg5, preg6, preg7,preg15,preg16,preg17 ], maximo = 7)

const nivel3 = new Nivel(preguntas = [ preg8, preg9, preg10, preg11,preg18,preg19,preg20 ], maximo = 10)

const niveles = [nivel1,nivel2,nivel3]

// Nivel 1

// Deseable
//  const preg1 = new Pregunta(respuestaCorrecta = [ "Francia" ], respuestasIncorrectas = [ ["Suiza"] ], text = "¿De qué país es originario el queso brie?", coleccion)
const preg1 = new Pregunta(respuestaCorrecta = [ r11 ], respuestasIncorrectas = [ r12 ], text = "¿De qué país es originario el queso brie?")

const r11 = new Respuesta(opcion = opA, text = "Francia")

const r12 = new Respuesta(opcion = opB, text = "Suiza")

const preg2 = new Pregunta(respuestaCorrecta = [ r21 ], respuestasIncorrectas = [ r22 ], text = "¿Qué fruto seco lleva en su interior un Ferrero Rocher?")

const r21 = new Respuesta(opcion = opA, text = "Avellana")

const r22 = new Respuesta(opcion = opB, text = "Almendra")

const preg3 = new Pregunta(respuestaCorrecta = [ r32 ], respuestasIncorrectas = [ r31 ], text = "¿Cuántas válvulas tiene un corazón humano?")

const r31 = new Respuesta(opcion = opA, text = "2")

const r32 = new Respuesta(opcion = opB, text = "4")

const preg4 = new Pregunta(respuestaCorrecta = [ r42 ], respuestasIncorrectas = [ r41 ], text = "¿Cuántos elementos forman la Tabla Periódica?")

const r41 = new Respuesta(opcion = opA, text = "112")

const r42 = new Respuesta(opcion = opB, text = "118")

const preg12 = new Pregunta(respuestaCorrecta = [ r121 ], respuestasIncorrectas = [ r122,r123 ], text = "¿Cuál de los siguientes sería atraído por un imán?")

const r121 = new Respuesta(opcion = opA, text = "Metal")

const r122 = new Respuesta(opcion = opB, text = "Plastico")

const r123 = new Respuesta(opcion = opC, text = "Madera")

const preg13 = new Pregunta(respuestaCorrecta = [ r134 ], respuestasIncorrectas = [ r132,r133,r131 ], text = "¿Que nombres no aparece en el título de una obra de Shakespeare?")

const r131 = new Respuesta(opcion = opA, text = "Hamlet")

const r132 = new Respuesta(opcion = opB, text = "Romeo")

const r133 = new Respuesta(opcion = opC, text = "Macbeth")

const r134 = new Respuesta(opcion = opD, text = "Darren")


const preg14 = new Pregunta(respuestaCorrecta = [ r142 ], respuestasIncorrectas = [ r144,r143,r141 ], text = "¿Qué nombre tiene tradicionalmente la fiesta que se hace a una mujer que espera un bebé?")

const r141 = new Respuesta(opcion = opA, text = "Baby drizzle")

const r142 = new Respuesta(opcion = opB, text = "Baby shower")

const r143 = new Respuesta(opcion = opC, text = "Baby downpour")

const r144 = new Respuesta(opcion = opD, text = "Baby deluge")

// Nivel 2
const preg5 = new Pregunta(respuestaCorrecta = [ r53 ], respuestasIncorrectas = [ r51, r52 ], text = "¿De qué película es el príncipe azul?")

const r51 = new Respuesta(opcion = opA, text = "Sirenita")

const r52 = new Respuesta(opcion = opB, text = "Bella Durmiente")

const r53 = new Respuesta(opcion = opC, text = "Cenicienta")

const preg6 = new Pregunta(respuestaCorrecta = [ r61 ], respuestasIncorrectas = [ r62, r63 ], text = "¿De qué país es Justin Biber?")

const r61 = new Respuesta(opcion = opA, text = "Canada")

const r62 = new Respuesta(opcion = opB, text = "USA")

const r63 = new Respuesta(opcion = opC, text = "Francia")

const preg7 = new Pregunta(respuestaCorrecta = [ r71 ], respuestasIncorrectas = [ r72, r73 ], text = "¿Quién pintó la Mona Lisa?")

const r71 = new Respuesta(opcion = opA, text = "Da Vinci")

const r72 = new Respuesta(opcion = opB, text = "Picasso")

const r73 = new Respuesta(opcion = opC, text = "Dali")

const preg15 = new Pregunta(respuestaCorrecta = [ r154 ], respuestasIncorrectas = [ r152,r153,r151 ], text = "¿Cuáles de estas aplicaciones ofrecen más o menos el mismo tipo de servicio?")

const r151 = new Respuesta(opcion = opA, text = "Snapchat y Grubhub")

const r152 = new Respuesta(opcion = opB, text = "Whatsapp y SHAREit")

const r153 = new Respuesta(opcion = opC, text = "TikTok y Spotify")

const r154 = new Respuesta(opcion = opD, text = "Lyft y Uber")

const preg16 = new Pregunta(respuestaCorrecta = [ r163 ], respuestasIncorrectas = [ r162,r164,r161 ], text = "Por definición, ¿qué tiene una bicicleta de 10 velocidades?")

const r161 = new Respuesta(opcion = opA, text = "10 Ruedas")

const r162 = new Respuesta(opcion = opB, text = "10 Rayos")

const r163 = new Respuesta(opcion = opC, text = "10 Piñones")

const r164 = new Respuesta(opcion = opD, text = "10 Vidas")

const preg17 = new Pregunta(respuestaCorrecta = [ r173 ], respuestasIncorrectas = [ r172,r171 ], text = "¿Qué parte importante de la topografía de Estados Unidos comprende aproximadamente un 20% del agua dulce de la Tierra?")

const r171 = new Respuesta(opcion = opA, text = "El valle de la Muerte")

const r172 = new Respuesta(opcion = opB, text = "El Gran Cañón")

const r173 = new Respuesta(opcion = opC, text = "Los grandes lagos")

// Nivel 3
const preg8 = new Pregunta(respuestaCorrecta = [ r84 ], respuestasIncorrectas = [ r81, r82, r83 ], text = "¿Qué planeta es el que se encuentra más cerca del Sol?")

const r81 = new Respuesta(opcion = opA, text = "Urano")

const r82 = new Respuesta(opcion = opB, text = "Saturno")

const r83 = new Respuesta(opcion = opC, text = "Marte")

const r84 = new Respuesta(opcion = opD, text = "Mercurio")

const preg9 = new Pregunta(respuestaCorrecta = [ r91 ], respuestasIncorrectas = [ r92, r93, r94 ], text = "¿A cuántos kilómetros equivale una milla?")

const r91 = new Respuesta(opcion = opA, text = "1.6")

const r92 = new Respuesta(opcion = opB, text = "1.8")

const r93 = new Respuesta(opcion = opC, text = "2.0")

const r94 = new Respuesta(opcion = opD, text = "2.2")

const preg10 = new Pregunta(respuestaCorrecta = [ r102 ], respuestasIncorrectas = [ r101, r103, r104 ], text = "¿De dónde es originario el mojito?")

const r101 = new Respuesta(opcion = opA, text = "Brasil")

const r102 = new Respuesta(opcion = opB, text = "Cuba")

const r103 = new Respuesta(opcion = opC, text = "Colombia")

const r104 = new Respuesta(opcion = opD, text = "Venezuela")

const preg11 = new Pregunta(respuestaCorrecta = [ r113 ], respuestasIncorrectas = [ r111, r112, r114 ], text = "¿Cuántos lados tiene un heptadecágono?")

const r111 = new Respuesta(opcion = opA, text = "15")

const r112 = new Respuesta(opcion = opB, text = "16")

const r113 = new Respuesta(opcion = opC, text = "17")

const r114 = new Respuesta(opcion = opD, text = "18")

const preg18 = new Pregunta(respuestaCorrecta = [ r183 ], respuestasIncorrectas = [ r182,r181 ], text = "¿Qué planta es el símbolo nacional de Irlanda?")

const r181 = new Respuesta(opcion = opA, text = "Rosa")

const r182 = new Respuesta(opcion = opB, text = "Cardo")

const r183 = new Respuesta(opcion = opC, text = "Trebol")

const preg19 = new Pregunta(respuestaCorrecta = [ r192 ], respuestasIncorrectas = [ r193,r191 ], text = "¿Cuál de estos es un instrumento musical?")

const r191 = new Respuesta(opcion = opA, text = "Mandrágora")

const r192 = new Respuesta(opcion = opB, text = "Mandolina")

const r193 = new Respuesta(opcion = opC, text = "Mandalay")

const preg20 = new Pregunta(respuestaCorrecta = [ r201 ], respuestasIncorrectas = [ r202,r203 ], text = "¿Cómo se llamaba la banda cuyo líder era Jim Morrison?")

const r201 = new Respuesta(opcion = opA, text = "The Doors")

const r202 = new Respuesta(opcion = opB, text = "The Windows")

const r203 = new Respuesta(opcion = opC, text = "The Floors")



