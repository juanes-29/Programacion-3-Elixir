defmodule NodoServidor do
  @ip_servidor "192.168.40.41"
  @servidor {:servidor, :"nodoservidor@#{@ip_servidor}"}
  @nombre_servicio_local :servicio_trabajos

  def main() do
    Util.mostrar_mensaje("========================================")
    Util.mostrar_mensaje("     SERVIDOR UNIQUINDÍO - TRABAJOS     ")
    Util.mostrar_mensaje("========================================")
    Util.mostrar_mensaje("Nodo: nodoservidor@#{@ip_servidor}")
    Util.mostrar_mensaje("Servicio: #{@nombre_servicio_local}")

    # Cargar datos iniciales
    inicializar_datos()

    Util.mostrar_mensaje("✅ Datos cargados correctamente")
    Util.mostrar_mensaje("📡 Esperando conexiones...")
    Util.mostrar_mensaje("========================================")

    registrar_servicio(@nombre_servicio_local)

    # Cargar datos en memoria
    estudiantes = Estudiante.cargar_csv("estudiantes.csv")
    trabajos = Trabajo.cargar_csv("trabajos.csv")

    procesar_mensajes(estudiantes, trabajos)
  end

  defp inicializar_datos() do
    # Crear datos de estudiantes si no existen
    unless File.exists?("estudiantes.csv") do
      estudiantes = [
        Estudiante.nuevo("Juan Pérez", "1094123456", "Ingeniería de Sistemas", "juan.perez@uniquindio.edu.co"),
        Estudiante.nuevo("María García", "1094234567", "Ingeniería de Sistemas", "maria.garcia@uniquindio.edu.co"),
        Estudiante.nuevo("Carlos López", "1094345678", "Ingeniería Civil", "carlos.lopez@uniquindio.edu.co"),
        Estudiante.nuevo("Ana Martínez", "1094456789", "Ingeniería de Sistemas", "ana.martinez@uniquindio.edu.co"),
        Estudiante.nuevo("Pedro Rodríguez", "1094567890", "Ingeniería Industrial", "pedro.rodriguez@uniquindio.edu.co")
      ]
      Estudiante.guardar_csv(estudiantes)
      Util.mostrar_mensaje("📝 Creados #{length(estudiantes)} estudiantes de prueba")
    end

    # Crear datos de trabajos si no existen
    unless File.exists?("trabajos.csv") do
      trabajos = [
        Trabajo.nuevo("TG001", "15/03/2024", "Sistema de Gestión Académica",
          "Desarrollo de un sistema web para la gestión de notas y horarios académicos",
          ["1094123456", "1094234567"]),
        Trabajo.nuevo("TG002", "20/05/2024", "App Móvil de Transporte Universitario",
          "Aplicación móvil para el seguimiento en tiempo real del transporte universitario",
          ["1094345678"]),
        Trabajo.nuevo("TG003", "10/08/2024", "Sistema de Inventarios con IoT",
          "Sistema de control de inventarios usando sensores IoT y análisis predictivo",
          ["1094456789", "1094567890"]),
        Trabajo.nuevo("TG004", "25/09/2024", "Plataforma de Tutorías Online",
          "Plataforma web para conectar estudiantes con tutores y gestionar sesiones virtuales",
          ["1094123456"])
      ]
      Trabajo.guardar_csv(trabajos)
      Util.mostrar_mensaje("📝 Creados #{length(trabajos)} trabajos de prueba")
    end
  end

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_mensajes(estudiantes, trabajos) do
    receive do
      {productor, mensaje} ->
        {respuesta, nuevos_estudiantes, nuevos_trabajos} = procesar_mensaje(mensaje, estudiantes, trabajos)
        send(productor, respuesta)

        if respuesta != :fin do
          procesar_mensajes(nuevos_estudiantes, nuevos_trabajos)
        end
    end
  end

  defp procesar_mensaje(:fin, estudiantes, trabajos), do: {:fin, estudiantes, trabajos}

  # Listar todos los trabajos
  defp procesar_mensaje({:listar_trabajos}, estudiantes, trabajos) do
    respuesta = case trabajos do
      [] -> "No hay trabajos registrados"
      _ ->
        lista = Trabajo.listar(trabajos)
        "=== TRABAJOS DE GRADO ===\n" <> Enum.join(lista, "\n")
    end
    {respuesta, estudiantes, trabajos}
  end

  # Listar todos los estudiantes
  defp procesar_mensaje({:listar_estudiantes}, estudiantes, trabajos) do
    respuesta = case estudiantes do
      [] -> "No hay estudiantes registrados"
      _ ->
        lista = Estudiante.listar(estudiantes)
        "=== ESTUDIANTES ===\n" <> Enum.join(lista, "\n")
    end
    {respuesta, estudiantes, trabajos}
  end

  # Buscar trabajo por título
  defp procesar_mensaje({:buscar_trabajo, titulo}, estudiantes, trabajos) do
    case Trabajo.buscar(titulo, trabajos) do
      nil ->
        {"❌ No se encontró trabajo con título: #{titulo}", estudiantes, trabajos}
      trabajo ->
        # Buscar autores
        autores_info = Enum.map(trabajo.autores_cedulas, fn cedula ->
          case Estudiante.buscar(cedula, estudiantes) do
            nil -> "#{cedula} (no encontrado)"
            est -> "#{est.nombre} (#{cedula})"
          end
        end)

        respuesta = """
        ✅ TRABAJO ENCONTRADO:
        ID: #{trabajo.id}
        Título: #{trabajo.titulo}
        Fecha: #{trabajo.fecha}
        Descripción: #{trabajo.descripcion}
        Autores: #{Enum.join(autores_info, ", ")}
        """
        {respuesta, estudiantes, trabajos}
    end
  end

  # Buscar estudiante por cédula
  defp procesar_mensaje({:buscar_estudiante, cedula}, estudiantes, trabajos) do
    case Estudiante.buscar(cedula, estudiantes) do
      nil ->
        {"❌ No se encontró estudiante con cédula: #{cedula}", estudiantes, trabajos}
      estudiante ->
        respuesta = """
        ✅ ESTUDIANTE ENCONTRADO:
        Nombre: #{estudiante.nombre}
        Cédula: #{estudiante.cedula}
        Programa: #{estudiante.programa}
        Email: #{estudiante.email}
        """
        {respuesta, estudiantes, trabajos}
    end
  end

  # Agregar nuevo estudiante
  defp procesar_mensaje({:agregar_estudiante, nombre, cedula, programa, email}, estudiantes, trabajos) do
    # Verificar si ya existe
    case Estudiante.buscar(cedula, estudiantes) do
      nil ->
        nuevo_estudiante = Estudiante.nuevo(nombre, cedula, programa, email)
        nuevos_estudiantes = [nuevo_estudiante | estudiantes]
        Estudiante.guardar_csv(nuevos_estudiantes)
        Util.mostrar_mensaje("✅ Estudiante agregado: #{nombre} (#{cedula})")
        {"✅ Estudiante agregado correctamente", nuevos_estudiantes, trabajos}
      _ ->
        {"❌ Ya existe un estudiante con cédula: #{cedula}", estudiantes, trabajos}
    end
  end

  # Agregar nuevo trabajo
  defp procesar_mensaje({:agregar_trabajo, id, fecha, titulo, descripcion, autores_cedulas}, estudiantes, trabajos) do
    # Verificar si ya existe
    case Trabajo.buscar_por_id(id, trabajos) do
      nil ->
        # Verificar que todos los autores existan
        autores_validos = Enum.all?(autores_cedulas, fn cedula ->
          Estudiante.buscar(cedula, estudiantes) != nil
        end)

        if autores_validos do
          nuevo_trabajo = Trabajo.nuevo(id, fecha, titulo, descripcion, autores_cedulas)
          nuevos_trabajos = [nuevo_trabajo | trabajos]
          Trabajo.guardar_csv(nuevos_trabajos)
          Util.mostrar_mensaje("✅ Trabajo agregado: #{titulo} (#{id})")
          {"✅ Trabajo agregado correctamente", estudiantes, nuevos_trabajos}
        else
          {"❌ Algunos autores no existen en el sistema", estudiantes, trabajos}
        end
      _ ->
        {"❌ Ya existe un trabajo con ID: #{id}", estudiantes, trabajos}
    end
  end

  # Mensaje desconocido
  defp procesar_mensaje(mensaje, estudiantes, trabajos) do
    {"❌ Mensaje desconocido: #{inspect(mensaje)}", estudiantes, trabajos}
  end
end

NodoServidor.main()
