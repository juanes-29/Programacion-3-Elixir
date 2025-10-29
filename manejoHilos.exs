defmodule Hilos do
  # Límite máximo de vehículos permitidos dentro del estacionamiento
  @aforoMaximo 5

  # Función pública que inicia el proceso semáforo con aforo inicial de 0
  def iniciar_semaforo() do
    spawn(fn -> semaforo(0) end)
  end

  # Proceso principal del semáforo
  # Controla el ingreso y salida de vehículos mediante mensajes
  # aforo_actual: número de vehículos dentro en este momento
  defp semaforo(aforo_actual) do
    receive do
      # Si llega un mensaje de entrada y aún hay espacio disponible:
      {:entrar, vehiculo, tiempo} when aforo_actual < @aforoMaximo ->
        Util.mostrar_mensaje("Carro #{vehiculo} entra. Aforo: #{aforo_actual + 1}")

        # Se genera un proceso para simular la estancia del vehículo
        spawn(fn -> estadia(vehiculo, tiempo, self()) end)

        # Se actualiza el aforo, manteniendo el bucle recursivo
        semaforo(aforo_actual + 1)

      # Si el estacionamiento está lleno, se rechaza al vehículo
      {:entrar, vehiculo, _tiempo} ->
        Util.mostrar_mensaje("Carro #{vehiculo} NO puede entrar. Aforo lleno.")
        semaforo(aforo_actual)

      # Cuando un vehículo termina su estancia, envía el mensaje :salir
      {:salir, vehiculo} ->
        Util.mostrar_mensaje("Carro #{vehiculo} sale. Aforo: #{aforo_actual - 1}")

        # Se decrementa aforo manteniendo el ciclo del proceso semáforo
        semaforo(aforo_actual - 1)
    end
  end

  # Proceso individual que simula la permanencia del vehículo dentro
  # Después de cierto tiempo, avisa al semáforo que salió
  defp estadia(vehiculo, tiempo, semaforo_pid) do
    Util.mostrar_mensaje("Carro #{vehiculo} está adentro por #{tiempo} ms")
    :timer.sleep(tiempo)
    send(semaforo_pid, {:salir, vehiculo})
  end

  # Función pública para pedir entrada de un vehículo al semáforo
  # Se envía un mensaje al proceso semáforo con el tiempo de estancia
  def entrar_vehiculo(semaforo_pid, vehiculo, tiempo) do
    send(semaforo_pid, {:entrar, vehiculo, tiempo})
  end
end

# Ejecución de ejemplo:
# Se inicia el semáforo y se envían 7 vehículos (más del aforo máximo de 5)
sem = Hilos.iniciar_semaforo()
for i <- 1..7 do
  Hilos.entrar_vehiculo(sem, i, 2000 + i*500)
end
