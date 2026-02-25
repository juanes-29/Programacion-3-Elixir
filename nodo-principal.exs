defmodule ClienteRemoto do
  # ⚠ CAMBIA ESTA IP POR LA IP DEL SERVIDOR
  # Para la misma máquina, usa: "192.168.1.68" o tu IP local
  # Para otra máquina, usa la IP de esa máquina
  @ip_servidor "192.168.40.41"  # <-- Cambia esto por la IP del servidor
  @servidor {:servidor, :"nodoservidor@#{@ip_servidor}"}

  def main() do
    IO.puts("[Cliente] Iniciando conexión remota...")
    IO.puts("[Cliente] Servidor objetivo: nodoservidor@#{@ip_servidor}")
    IO.puts("")
    IO.puts("Comandos disponibles:")
    IO.puts("  mayus <texto>     - Convierte a MAYÚSCULAS")
    IO.puts("  minus <texto>     - Convierte a minúsculas")
    IO.puts("  reverse <texto>   - Invierte el texto")
    IO.puts("  <texto>           - Envía texto directo")
    IO.puts("  salir             - Terminar sesión")
    IO.puts("")

    nodo_servidor = :"nodoservidor@#{@ip_servidor}"

    case Node.connect(nodo_servidor) do
      true ->
        IO.puts("[Cliente] ✅ Conexión establecida con #{nodo_servidor}")
        enviar_mensajes()

      false ->
        IO.puts("[Cliente] ❌ No se pudo conectar al servidor.")
        IO.puts("")
        IO.puts("Posibles causas:")
        IO.puts("1. El servidor no está corriendo")
        IO.puts("2. La IP #{@ip_servidor} es incorrecta")
        IO.puts("3. El firewall está bloqueando la conexión")
        IO.puts("4. Las cookies no coinciden")
        IO.puts("")
        IO.puts("Verifica que el servidor esté corriendo con:")
        IO.puts("  elixir --name nodoservidor@#{@ip_servidor} --cookie micookie123 nodo-secundario.exs")
    end
  end

  defp enviar_mensajes() do
    msg = IO.gets("[Cliente] > ") |> String.trim()

    if msg == "salir" do
      IO.puts("[Cliente] Fin de la sesión.")
      send(@servidor, {self(), :fin})
    else
      mensaje_procesado = procesar_comando(msg)
      send(@servidor, {self(), mensaje_procesado})
      recibir_respuesta()
      enviar_mensajes()
    end
  end

  defp procesar_comando("mayus " <> texto), do: {:mayusculas, texto}
  defp procesar_comando("minus " <> texto), do: {:minusculas, texto}
  defp procesar_comando("reverse " <> texto), do: {&String.reverse/1, texto}
  defp procesar_comando(texto), do: texto

  defp recibir_respuesta() do
    receive do
      msg ->
        IO.puts("[Cliente] Respuesta: #{msg}")
    after
      3000 ->
        IO.puts("[Cliente] ⏱ No hubo respuesta del servidor.")
    end
  end
end

ClienteRemoto.main()
