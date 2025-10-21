defmodule Carrera do
  # inicia la simulación de la carrera
  def iniciar do
    IO.puts("🏁 ¡Comienza la carrera de animales! 🏁\n")

    # Lista de animales con su nombre y velocidad en km/h
    animales = [
      {"🐢 Tortuga", 2},
      {"🐇 Liebre", 20},
      {"🦁 León", 25}
    ]

    # Distancia total de la carrera (en metros)
    distancia_total = 100

    # Guardamos el PID del proceso "juez"
    # Este proceso recibirá los mensajes de los competidores
    juez = self()

    # Para cada animal, creamos un proceso independiente que correrá la carrera
    Enum.each(animales, fn {nombre, vel_kmh} ->
      # spawn/1 crea un nuevo proceso concurrente
      spawn(fn -> correr(nombre, vel_kmh, distancia_total, juez) end)
    end)

    # Esperamos los resultados de todos los animales
    # length(animales) indica cuántos mensajes debemos recibir
    recibir_resultados([], length(animales))
  end

  # Función privada que simula a un animal corriendo

  defp correr(nombre, vel_kmh, distancia, juez) do
    # Convertimos la velocidad de km/h a m/s
    vel_ms = vel_kmh * 1000 / 3600

    # Calculamos el tiempo (en segundos) que tardaría en recorrer la distancia
    tiempo = distancia / vel_ms

    # Convertimos ese tiempo a milisegundos
    # Multiplicamos por 100 para que la carrera no dure demasiado
    duracion = trunc(tiempo * 100)

    # Mostramos en consola la velocidad del animal
    IO.puts("#{nombre} corre a #{vel_kmh} km/h...")

    # Simulamos el tiempo que tarda en llegar (bloquea sólo su proceso)
    :timer.sleep(duracion)

    # Avisamos que el animal llegó a la meta
    IO.puts("#{nombre} 🏁 llegó a la meta!")

    # Enviamos un mensaje al juez con el nombre del animal
    send(juez, {:llego, nombre})
  end

  # Función que recibe los resultados de los animales

  # Caso 1️⃣: aún no han llegado todos los animales
  defp recibir_resultados(llegadas, total) when length(llegadas) < total do
    receive do
      # Recibimos un mensaje de tipo {:llego, nombre}
      {:llego, nombre} ->
        # Calculamos la posición del animal según cuántos llegaron antes
        posicion = length(llegadas) + 1

        IO.puts("#{nombre} llegó en posición #{posicion}")

        # Añadimos el animal a la lista de llegadas y esperamos más
        recibir_resultados(llegadas ++ [nombre], total)
    end
  end

  # Caso 2️⃣: ya llegaron todos los animales
  defp recibir_resultados(llegadas, _total) do
    # El primer elemento de la lista es el ganador
    [ganador | _] = llegadas

    IO.puts("\n🥇 ¡El ganador es #{ganador}!")
  end
end

Carrera.iniciar()
